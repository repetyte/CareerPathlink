import 'package:flutter/material.dart';
import 'package:flutter_app/models/career_coaching/student_notification_model.dart';
import 'package:flutter_app/models/user_role/coach_model.dart';
import 'package:flutter_app/pages/students_account/career_coaching/notification_provider.dart';
import 'package:flutter_app/pages/students_account/student_profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/user_role/student.dart';
import '../../../widgets/appbar/student_header.dart';
import '../../../widgets/drawer/drawer_students.dart';
import '../../../widgets/footer/footer.dart';
import '../../login_and_signup/login_view.dart';
import 'select_coach_screen.dart';

class AppointmentBookingScreen extends StatefulWidget {
  CoachAccount? coachAccount;
  final StudentAccount studentAccount;
  AppointmentBookingScreen({super.key, required this.studentAccount, this.coachAccount});

  @override
  _AppointmentBookingScreenState createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  String? _currentUserId; // This is the line that was missing
  StudentNotification? _selectedNotification;
  bool _showNotificationDetails = false;
  OverlayEntry? _notificationOverlayEntry;
  final GlobalKey _bellIconKey = GlobalKey();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // _currentUserId = widget.studentAccount.username;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserId();
    });
    debugPrint('Current user ID: $_currentUserId');
  }

  Future<void> _loadUserId() async {
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final userId = prefs.getString('user_id');
      final userId = widget.studentAccount.username;
      debugPrint('Loaded user ID from preferences: $userId');

      setState(() => _currentUserId = userId);
      await Provider.of<StudentNotificationProvider>(context, listen: false)
          .loadNotifications(userId);
        } catch (e) {
      debugPrint('Error loading user ID: $e');
    }
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  void _showNotificationPopup(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox =
        _bellIconKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      debugPrint('Could not find bell icon render box');
      return;
    }

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    debugPrint('Showing notification popup at position: $position');

    _notificationOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + size.height + 8,
        right: MediaQuery.of(context).size.width - position.dx - size.width,
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
                )
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
    final notificationProvider =
        Provider.of<StudentNotificationProvider>(context, listen: true);

    return _showNotificationDetails && _selectedNotification != null
        ? _buildNotificationDetailsView(_selectedNotification!)
        : _buildNotificationListView(notificationProvider);
  }

  Widget _buildNotificationListView(StudentNotificationProvider provider) {
    debugPrint(
        'Building notification list with ${provider.notifications.length} items');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications (${provider.unreadCount})',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              if (provider.unreadCount > 0)
                TextButton(
                  onPressed: () => provider.markAllAsRead(),
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
        Expanded(
          child: provider.notifications.isEmpty
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
                  itemCount: provider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = provider.notifications[index];
                    debugPrint(
                        'Building notification item $index: ${notification.message}');
                    return _buildNotificationItem(
                      icon: _getNotificationIcon(notification.notificationType),
                      title: notification.displayType,
                      message: notification.message ?? 'No message',
                      time: _formatTime(notification.createdAt),
                      isUnread: notification.isUnread,
                      notification: notification,
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: TextButton(
            onPressed: () {
              // TODO: Navigate to full notifications page
            },
            child: Text(
              'View all notifications',
              style: GoogleFonts.montserrat(
                color: Color(0xFFEC1D25),
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }

  // In your HeaderWidget class
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required StudentNotification notification,
  }) {
    return InkWell(
      onTap: () {
        final provider = context.read<StudentNotificationProvider>();

        // Mark as read if it's unread
        if (notification.isUnread) {
          provider.markAsRead(notification.id);
        }

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

  Widget _buildNotificationDetailsView(StudentNotification notification) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          _getNotificationIcon(notification.notificationType),
                          color: Color(0xFFEC1D25),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.displayType,
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
                  Divider(height: 1, thickness: 1),
                  SizedBox(height: 16),
                  if (notification.message != null)
                    Text(
                      notification.message!,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  SizedBox(height: 16),
                  if (notification.dateRequested != null)
                    Text(
                      'Scheduled for: ${DateFormat('MMM d, y').format(notification.dateRequested!)} '
                      'at ${notification.timeRequested ?? ''}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'Accepted Appointment':
        return Icons.check_circle_outline;
      case 'Declined Appointment':
        return Icons.cancel_outlined;
      case 'Completed Appointment':
        return Icons.done_all;
      case 'Cancelled Appointment':
        return Icons.event_busy;
      case 'Accepted Reschedule Request':
        return Icons.schedule;
      case 'Declined Reschedule Request':
        return Icons.schedule_send;
      default:
        return Icons.notifications;
    }
  }

  String _formatTime(DateTime date) {
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

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width for the dialog
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      '${widget.studentAccount.firstName} ${widget.studentAccount.lastName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Student | ${widget.studentAccount.course}'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box),
                    title: const Text('Profile'),
                    onTap: () {
                      // Handle profile navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfileScreen(
                            studentAccount: widget.studentAccount,
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

  @override
  Widget build(BuildContext context) {
    // Detect if the platform is mobile or web
    final notificationProvider = context.watch<StudentNotificationProvider>();
    bool isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            'assets/images/seal_of_university_of_nueva_caceres_2.png'),
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
                        child: Icon(Icons.notifications_active_outlined,
                            size: 26, color: Color(0xFFEC1D25)),
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
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: const NetworkImage(
                                    'assets/career_coaching/student_profile.jpg'), // Add the path to your profile image
                                radius: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
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
      drawer: MyDrawerStudents(
        studentAccount: widget.studentAccount, coachAccount: widget.coachAccount,
      ),
      body: Column(
        children: [
          // Header with shadow
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 4.0,
              shadowColor: Colors.black.withOpacity(0.3),
              child: const HeaderStudent(),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main content
                  // Main content

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
                                    'Appointment Booking',
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
                                    'Welcome to the UNC Career Coaching Platform. Review all fields in the online form carefully and provide complete and accurate information.',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Terms and Conditions",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 80,
                            top: 20,
                            right: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 5,
                                height: 60,
                                color: Color(0xFFEC1D25),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reminder:",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFEC1D25),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Please ensure you have a valid UNC email address to access the platform. The platform is designed for seamless integration with various devices and browsers.",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Text(
                            "This appointment and scheduling system allocates slots on a first come, first served basis. Users are responsible for supplying, checking, and verifying the accuracy of the information they provide. Incorrect information may result in session cancellation.",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: _toggleCheckbox,
                                activeColor: Color(0xFFEC1D25),
                              ),
                              Expanded(
                                child: Text(
                                  "By proceeding with this application, you understand that you are signifying your consent to the collection and use of your personal information for the purpose of facilitating services.",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFFEC1D25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // "Start Schedule an Appointment" button wrapped in GestureDetector
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: isChecked
                                ? () {
                                    // Navigate to SelectCoachScreen when tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectCoachScreen(
                                          studentAccount: widget.studentAccount, coachAccount: widget.coachAccount, // Pass null or a default value
                                        ),
                                      ),
                                    );
                                  }
                                : null, // Disable tap if checkbox is unchecked
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isChecked
                                    ? Color(0xFFEC1D25) // Active color
                                    : Colors.grey, // Inactive color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Text(
                                  "Start Schedule an Appointment",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // The new text aligned differently based on screen size
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ), // Some space above the text
                          child: Align(
                            alignment: isWeb
                                ? Alignment.center // Center text for web
                                : Alignment
                                    .centerLeft, // Left-align text for mobile
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ), // Added horizontal padding for alignment
                              child: Text(
                                "After agreeing to the Terms and Conditions above, you may start your online application by clicking “Start Appointment”",
                                style: GoogleFonts.beVietnamPro(
                                  fontWeight: FontWeight.w300, // Light weight
                                  fontSize: 14, // Adjust size if needed
                                  color: Color(0xFF6C6868), // The desired color
                                ),
                                textAlign: isWeb
                                    ? TextAlign.center // Center the text on web
                                    : TextAlign.left, // Align left on mobile
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Footer at the bottom of the page
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
