// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_app/models/career_coaching/request_appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/career_coaching/wdt_notifications_model.dart';
import 'package:flutter_app/pages/wdt_account/coach_profile_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/notification_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/services/career_coaching/api_services.dart' as api_services;
import 'package:flutter_app/pages/wdt_account/career_coaching/coach_home_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/reschedule_request_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/schedules_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/user_role/coach_model.dart';
import '../../../models/user_role/student.dart';
import '../../../widgets/appbar/coach_header.dart';
import '../../../widgets/drawer/drawer_wdt.dart';
import '../../login_and_signup/login_view.dart';

// Add these color constants at the top
const Color darkAcceptColor = Color(0xFF0F9D58); // Darker green
const Color darkDeclineColor = Color(0xFFC62828); // Darker red
const Color darkAcceptShadowColor = Color(0xFF81C784); // Darker green shadow
const Color darkDeclineShadowColor = Color(0xFFE57373); // Darker red shadow

class RequestScheduleScreen extends StatefulWidget {
  final CoachAccount coachAccount;
  StudentAccount? studentAccount;
  RequestScheduleScreen(
      {super.key, required this.coachAccount, this.studentAccount});

  @override
  _RequestScheduleScreenState createState() => _RequestScheduleScreenState();
}

class _RequestScheduleScreenState extends State<RequestScheduleScreen> {
  String _selectedText = 'Request Schedules';
  final TextEditingController _searchController = TextEditingController();
  List<Appointment> appointments = [];
  List<Appointment> filteredAppointments = [];
  bool isLoading = true;
  String? _userId;
  String? _currentUserId;
  WDTNotification? _selectedNotification;
  bool _showNotificationDetails = false;
  OverlayEntry? _notificationOverlayEntry;
  final GlobalKey _bellIconKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterAppointments);
    fetchAppointments();
    _loadUserId();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showNotificationPopup(context);
    // });
  }

  Future<void> _loadUserId() async {
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _currentUserId = prefs.getString('user_id');
      _currentUserId = widget.coachAccount.username;
      debugPrint('Loaded user ID from preferences: $_currentUserId');
    });

    if (_currentUserId != null) {
      debugPrint('Loading notifications for user: $_currentUserId');
      context.read<NotificationProvider>().loadNotifications(_currentUserId!);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _filterAppointments() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredAppointments = List.from(appointments);
      } else {
        filteredAppointments = appointments.where((appointment) {
          return appointment.studentName.toLowerCase().contains(query) ||
              appointment.dateRequested.toLowerCase().contains(query) ||
              appointment.timeRequested.toLowerCase().contains(query) ||
              appointment.serviceType.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> fetchAppointments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiService = api_services.ApiService(
          coachAccount: widget.coachAccount,
          studentAccount: widget.studentAccount);
      List<Appointment> fetchedAppointments =
          await apiService.getPendingAppointments();

      setState(() {
        appointments = fetchedAppointments;
        filteredAppointments = List.from(appointments);
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching appointments: $e");
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to load appointments. Please try again."),
      ));
    }
  }

  String formatDateString(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final monthNames = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String formatTimeString(String timeString) {
    try {
      final timeParts = timeString.split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        int endHour = hour;
        int endMinute = minute + 30;
        if (endMinute >= 60) {
          endHour += 1;
          endMinute -= 60;
        }

        String formatTime(int hour, int minute) {
          String period = hour >= 12 ? 'PM' : 'AM';
          int displayHour = hour > 12 ? hour - 12 : hour;
          if (displayHour == 0) displayHour = 12;
          return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }

        return '${formatTime(hour, minute)} - ${formatTime(endHour, endMinute)}';
      }
    } catch (e) {
      return timeString;
    }
    return timeString;
  }

  String formatServiceType(String serviceType) {
    // Convert enum-style strings to more readable format
    return serviceType
        .replaceAll('_', ' ') // Replace underscores with spaces
        .split(' ') // Split into words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' '); // Capitalize each word
  }

  Future<bool> _showAcceptConfirmationDialog(Appointment appointment) async {
    String formattedDate = formatDateString(appointment.dateRequested);
    String formattedTime = formatTimeString(appointment.timeRequested);
    String formattedService = formatServiceType(appointment.serviceType);

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder(
                    tween: ColorTween(
                      begin: Colors.grey[300],
                      end: darkAcceptColor,
                    ),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, color, child) => Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Confirm Appointment",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[200] ?? Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          Icons.person_outline,
                          "Student:",
                          appointment.studentName,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.work_outline,
                          "Service:",
                          formattedService,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.calendar_today_outlined,
                          "Date:",
                          formattedDate,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.access_time_outlined,
                          "Time:",
                          formattedTime,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "This will notify ${appointment.studentName.split(' ')[0]} "
                    "that you've accepted their appointment request.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.grey[700],
                            ),
                            child: Text(
                              "Not Now",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 1, end: 1),
                        duration: const Duration(milliseconds: 150),
                        builder: (context, scale, child) => Transform.scale(
                          scale: scale,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkAcceptColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 1,
                              shadowColor: darkAcceptShadowColor,
                            ),
                            child: Text(
                              "Accept",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width for the dialog
            ),
            // height: screenSize.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      widget.coachAccount.coachName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Workforce Development Trainer'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoachProfileScreen(
                            coachAccount: widget.coachAccount,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNotificationPopup(BuildContext context) {
    final overlay = Overlay.of(context);
    final RenderBox renderBox =
        _bellIconKey.currentContext!.findRenderObject() as RenderBox;
    final bellIconPosition = renderBox.localToGlobal(Offset.zero);
    final bellIconSize = renderBox.size;

    _notificationOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: bellIconPosition.dy + bellIconSize.height + 8,
        right: MediaQuery.of(context).size.width -
            bellIconPosition.dx -
            bellIconSize.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: _buildNotificationContent(),
          ),
        ),
      ),
    );

    overlay.insert(_notificationOverlayEntry!);
  }

  void _hideNotificationPopup() {
    _notificationOverlayEntry?.remove();
    _notificationOverlayEntry = null;
    setState(() {
      _showNotificationDetails = false;
    });
  }

  Widget _buildNotificationContent() {
    final notificationProvider = context.read<NotificationProvider>();

    return _showNotificationDetails && _selectedNotification != null
        ? _buildNotificationDetailsView(_selectedNotification!)
        : _buildNotificationListViewAlt(notificationProvider);
  }

  Widget _buildNotificationListViewAlt(
      NotificationProvider notificationProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications (${notificationProvider.unreadCount})',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              if (notificationProvider.unreadCount > 0)
                TextButton(
                  onPressed: () => notificationProvider.markAllAsRead(),
                  child: Text(
                    'Mark all as read',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFEC1D25),
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
        // Scrollable notification list
        Expanded(
          child: notificationProvider.notifications.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No notifications found',
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: notificationProvider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        notificationProvider.notifications[index];
                    return _buildNotificationItem(
                      icon: _getNotificationIcon(notification.notificationType),
                      title: _getNotificationTitle(notification),
                      message: notification.message ?? 'No message',
                      time: _formatTimes(notification.createdAt),
                      isUnread: notification.status == 'Unread',
                      notification: notification,
                    );
                  },
                ),
        ),
        // Footer
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: TextButton(
            onPressed: () {
              // View all functionality
            },
            child: Text(
              'View all notifications',
              style: GoogleFonts.montserrat(
                color: Color(0xFFEC1D25),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required WDTNotification notification,
  }) {
    return InkWell(
      onTap: () {
        final notificationProvider = context.read<NotificationProvider>();
        notificationProvider.markAsRead(notification.id);

        setState(() {
          _selectedNotification = notification;
          _showNotificationDetails = true;
        });

        _notificationOverlayEntry?.markNeedsBuild();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isUnread
              ? Color(0xFFEC1D25).withOpacity(0.05)
              : Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFEC1D25).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Color(0xFFEC1D25), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFFEC1D25),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationDetailsView(WDTNotification notification) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFFEC1D25), Color(0xFFC2185B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification Details',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _showNotificationDetails = false;
                    });
                    _notificationOverlayEntry?.markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
        ),

        // Notification card with shadow and animation
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0.9, end: 1.0),
                curve: Curves.easeOutBack,
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Notification header with icon
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEC1D25).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _getNotificationIcon(
                                        notification.notificationType),
                                    color: Color(0xFFEC1D25),
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getNotificationTitle(notification),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        DateFormat('MMM d, y hh:mm a')
                                            .format(notification.createdAt),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Decorative divider
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  color: Colors.white,
                                  child: Text(
                                    'DETAILS',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: Colors.grey.shade500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Notification content with animated reveal
                            TweenAnimationBuilder(
                              duration: Duration(milliseconds: 500),
                              tween: Tween<double>(begin: 0, end: 1),
                              builder: (context, double value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 20 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  notification.message ??
                                      'No details available',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.grey.shade800,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'New Appointment':
        return Icons.calendar_today;
      case 'Reschedule Request':
        return Icons.schedule;
      case 'Cancellation':
        return Icons.cancel;
      default:
        return Icons.notifications;
    }
  }

  String _getNotificationTitle(WDTNotification notification) {
    switch (notification.notificationType) {
      case 'New Appointment':
        return 'New Appointment Request';
      case 'Reschedule Request':
        return 'Reschedule Request';
      case 'Cancellation':
        return 'Appointment Cancelled';
      default:
        return 'Notification';
    }
  }

  String _formatTimes(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1)
      return '${difference.inMinutes} mins ago';
    else if (difference.inDays < 1)
      return '${difference.inHours} hours ago';
    else if (difference.inDays < 7)
      return '${difference.inDays} days ago';
    else
      return DateFormat('MMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    // Adjust this based on your header height
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/seal_of_university_of_nueva_caceres_2.png',
                        ),
                      ),
                    ),
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'UNC ',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      Text(
                        'Career',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                      Text(
                        'Pathlink',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (_notificationOverlayEntry == null) {
                        _showNotificationPopup(context);
                      } else {
                        _hideNotificationPopup();
                      }
                    },
                    child: Container(
                      key: _bellIconKey,
                      padding: EdgeInsets.all(8),
                      child: Badge(
                        label: Text('${notificationProvider.unreadCount}',
                            style: TextStyle(color: Colors.white)),
                        isLabelVisible: notificationProvider.unreadCount > 0,
                        backgroundColor: Color(0xFFEC1D25),
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 1.0, end: 1.2),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Icon(Icons.notifications_active_outlined,
                                  size: 26, color: Color(0xFFEC1D25)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _showProfileDialog(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SizedBox(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 4, 14, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    'assets/career_coaching/1709211669228.jpg'), // Add the path to your profile image
                                radius: 24,
                              ),
                              // Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Partner Name',
                              //           style: GoogleFonts.getFont(
                              //             'Montserrat',
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 14,
                              //             color: const Color(0xFF000000),
                              //           )),
                              //       Text('Employer Partner',
                              //           style: GoogleFonts.getFont(
                              //             'Montserrat',
                              //             fontWeight: FontWeight.normal,
                              //             fontSize: 12,
                              //             color: const Color(0xFF000000),
                              //           )),
                              //     ]),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
                                width: 12,
                                height: 7.4,
                                child: SizedBox(
                                  width: 12,
                                  height: 7.4,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_331_x2.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 92,
      ),
      drawer: MyDrawerCoach(
        coachAccount: widget.coachAccount,
        studentAccount: widget.studentAccount,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 4.0,
              shadowColor: Colors.black.withOpacity(0.3),
              child: const HeaderCoach(),
            ),
          ),

          // Main content with padding to account for the fixed header
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Career Coaching',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/rectangle_223.jpeg',
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x80000000),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const SizedBox(
                              width: 380,
                              height: 200,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Manage Appointments',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'The Career Center Office is staffed with dedicated counselors who assist students in identifying a suitable career path, regardless of whether they already have a specific occupation in mind or are unsure about their direction.',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildTextWithUnderline('Dashboard', 16, context),
                        SizedBox(width: 20),
                        _buildTextWithUnderline(
                            'Request Schedules', 16, context),
                        SizedBox(width: 20),
                        _buildTextWithUnderline(
                            'Reschedule Request', 16, context),
                        SizedBox(width: 20),
                        _buildTextWithUnderline('Schedules', 16, context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.search, color: Color(0xFF9CA3AF)),
                              hintText: 'Search students...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Requested Appointments',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : filteredAppointments.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off,
                                      size: 48, color: Colors.grey),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'No Request'
                                        : 'No result found',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3.9,
                                ),
                                itemCount: filteredAppointments.length,
                                itemBuilder: (context, index) {
                                  return buildRequestCard(
                                      filteredAppointments[index]);
                                },
                              ),
                            ),
                ],
              ),
            ),
          ),
          // Fixed header positioned at the top
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Material(
          //     elevation: 4.0,
          //     color: Colors.white,
          //     child: const CoachHeader(), // Your header
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildRequestCard(Appointment appointment) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage:
                      AssetImage('assets/career_coaching/student_profile.jpg'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              appointment.studentName,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          // Service type positioned to the right
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Text(
                              formatServiceType(appointment.serviceType)
                                  .toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.red[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      if (appointment.dateRequested != null)
                        Text(
                          "Date: ${formatDateString(appointment.dateRequested)}",
                          style: GoogleFonts.montserrat(fontSize: 13),
                        ),
                      if (appointment.timeRequested != null)
                        Text(
                          "Time: ${formatTimeString(appointment.timeRequested)}",
                          style: GoogleFonts.montserrat(fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _handleDeclineAppointment(appointment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkDeclineColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text("Decline", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _handleAcceptAppointment(appointment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkAcceptColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: Icon(Icons.check, color: Colors.white),
                  label: Text("Accept", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showDeclineConfirmationDialog(Appointment appointment) async {
    String formattedDate = formatDateString(appointment.dateRequested);
    String formattedTime = formatTimeString(appointment.timeRequested);
    String formattedService = formatServiceType(appointment.serviceType);

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder(
                    tween: ColorTween(
                      begin: Colors.grey[300],
                      end: darkDeclineColor,
                    ),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, color, child) => Icon(
                      Icons.warning_amber_rounded,
                      size: 48,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Decline Appointment?",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[200] ?? Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          Icons.person_outline,
                          "Student:",
                          appointment.studentName,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.work_outline,
                          "Service:",
                          formattedService,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.calendar_today_outlined,
                          "Date:",
                          formattedDate,
                        ),
                        const Divider(height: 16, thickness: 0.5),
                        _buildDetailRow(
                          Icons.access_time_outlined,
                          "Time:",
                          formattedTime,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "This will notify ${appointment.studentName.split(' ')[0]} that "
                    "you're unavailable. They'll be encouraged to request another time.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.grey[700],
                            ),
                            child: Text(
                              "Go Back",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 1, end: 1),
                        duration: const Duration(milliseconds: 150),
                        builder: (context, scale, child) => Transform.scale(
                          scale: scale,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkDeclineColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 1,
                              shadowColor: darkDeclineShadowColor,
                            ),
                            child: Text(
                              "Decline",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Update your _handleDeclineAppointment method
  Future<void> _handleDeclineAppointment(Appointment appointment) async {
    bool confirm = await showDeclineConfirmationDialog(appointment);
    if (!confirm) return;

    try {
      bool isDeclined = await api_services.ApiService.declineAppointment(appointment.id);

      if (isDeclined) {
        setState(() {
          appointments.removeWhere((a) => a.id == appointment.id);
          filteredAppointments.removeWhere((a) => a.id == appointment.id);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Appointment declined!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to decline appointment"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${e.toString()}"),
      ));
    }
  }

// Update your _handleAcceptAppointment method
  Future<void> _handleAcceptAppointment(Appointment appointment) async {
    bool confirm = await _showAcceptConfirmationDialog(appointment);
    if (!confirm) return;

    try {
      final success = await api_services.ApiService.acceptAppointment(appointment.id);
      debugPrint('Appointment accept success: $success');

      if (success) {
        setState(() {
          appointments.removeWhere((a) => a.id == appointment.id);
          filteredAppointments.removeWhere((a) => a.id == appointment.id);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Appointment accepted!'),
        ));
      } else {
        throw Exception('Failed to accept appointment');
      }
    } catch (e) {
      debugPrint('Error in _handleAcceptAppointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
      ));
    }
  }

  Widget _buildTextWithUnderline(
      String text, double fontSize, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedText = text;
        });
        if (text == 'Dashboard') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => NotificationProvider(),
                child: CoachScreen(
                    coachAccount: widget.coachAccount,
                    studentAccount: widget.studentAccount),
              ),
            ),
          );
        } else if (text == 'Request Schedules') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => NotificationProvider(),
                child: RequestScheduleScreen(
                    coachAccount: widget.coachAccount,
                    studentAccount: widget.studentAccount),
              ),
            ),
          );
        } else if (text == 'Reschedule Request') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => NotificationProvider(),
                child: RescheduleRequestScreen(
                    coachAccount: widget.coachAccount,
                    studentAccount: widget.studentAccount),
              ),
            ),
          );
        } else if (text == 'Schedules') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => NotificationProvider(),
                child: SchedulesScreen(
                    coachAccount: widget.coachAccount,
                    studentAccount: widget.studentAccount),
              ),
            ),
          );
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: fontSize,
              fontWeight:
                  _selectedText == text ? FontWeight.bold : FontWeight.normal,
              color: _selectedText == text ? Colors.red : Colors.black,
            ),
          ),
          if (_selectedText == text)
            Positioned(
              bottom: -3,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Color(0xFFFF0000)),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
