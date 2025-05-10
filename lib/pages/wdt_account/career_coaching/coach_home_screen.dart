import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_app/pages/wdt_account/career_coaching/request_schedule_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/reschedule_request_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/schedules_screen.dart';
import 'package:flutter_app/services/career_coaching/api_services.dart';
import 'package:flutter_app/models/career_coaching/time_slot.dart';
import '../../../models/user_role/coach_model.dart';
import '../../../widgets/appbar/coach_header.dart';
import '../../../widgets/drawer/drawer_wdt.dart';
import '../../../widgets/shared_preferences_helper.dart';
import '../../login_and_signup/login_view.dart';

class CoachScreen extends StatefulWidget {
  final CoachAccount coachAccount;
  const CoachScreen({super.key, required this.coachAccount});

  @override
  _CoachScreenState createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  String _selectedText = 'Dashboard';
  final Map<String, int> _slotIdMapping = {};
  final Map<DateTime, List<TimeSlot>> _dateSpecificSlots = {};
  bool _isLoading = false;
  String? _userId;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? userIdString = await UserPreferences.getUserId();
      if (userIdString == null) {
        debugPrint('No user ID found in preferences');
        // Handle case where user is not logged in (redirect to login)
        return;
      }

      _userId = userIdString;
      debugPrint('Loaded user ID from preferences: $_userId');
      await _fetchSlots();
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchSlots() async {
    if (_userId == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // No need to parse or replace anything, just pass the user_id as is
      Map<String, List<TimeSlot>> slotsByDate =
          await ApiService.fetchTimeSlots(_userId!);

      if (mounted) {
        setState(() {
          _slotIdMapping.clear();
          _dateSpecificSlots.clear();

          slotsByDate.forEach((dateString, slots) {
            for (var slot in slots) {
              DateTime slotDate;
              try {
                slotDate = DateFormat('MMMM d, yyyy').parse(slot.dateSlot);
              } catch (e) {
                try {
                  slotDate = DateTime.parse(slot.dateSlot);
                } catch (e) {
                  debugPrint("Failed to parse date: ${slot.dateSlot}");
                  continue;
                }
              }

              final normalizedDate =
                  DateTime(slotDate.year, slotDate.month, slotDate.day);
              _dateSpecificSlots
                  .putIfAbsent(normalizedDate, () => [])
                  .add(slot);

              String slotKey =
                  "${DateFormat('yyyy-MM-dd').format(normalizedDate)}|${slot.startTime}-${slot.endTime}";
              _slotIdMapping[slotKey] = slot.id;
            }
          });
        });
      }
    } catch (e) {
      debugPrint("Error fetching slots: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to refresh slots: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshSlots() async {
    await _fetchSlots();
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
                      // Navigate to profile
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
                          backgroundImage: AssetImage(
                              'assets/images/image_12.png'), // Add the path to your profile image
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
        toolbarHeight: 92,
      ),
      
      drawer: MyDrawerCoach(coachAccount: widget.coachAccount,),
      
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
                        _buildNavItem('Dashboard', 16, context),
                        SizedBox(width: 20),
                        _buildNavItem('Request Schedules', 16, context),
                        SizedBox(width: 20),
                        _buildNavItem('Reschedule Request', 16, context),
                        SizedBox(width: 20),
                        _buildNavItem('Schedules', 16, context),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Time Slot Manager',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                _isLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                        strokeWidth: 2,
                                      )
                                    : IconButton(
                                        icon: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red.withOpacity(0.1),
                                          ),
                                          child: Icon(Icons.refresh,
                                              color: Colors.red, size: 20),
                                        ),
                                        onPressed: _refreshSlots,
                                      ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: TableCalendar(
                                      firstDay: DateTime.utc(2010, 10, 16),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      focusedDay: _focusedDay,
                                      calendarFormat: _calendarFormat,
                                      selectedDayPredicate: (day) =>
                                          isSameDay(_selectedDay, day),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        setState(() {
                                          _selectedDay = selectedDay;
                                          _focusedDay = focusedDay;
                                        });
                                      },
                                      onFormatChanged: (format) {
                                        setState(() {
                                          _calendarFormat = format;
                                        });
                                      },
                                      onPageChanged: (focusedDay) {
                                        _focusedDay = focusedDay;
                                      },
                                      eventLoader: (day) {
                                        final normalizedDate = DateTime(
                                            day.year, day.month, day.day);
                                        return _dateSpecificSlots
                                                .containsKey(normalizedDate)
                                            ? ['']
                                            : [];
                                      },
                                      calendarStyle: CalendarStyle(
                                        defaultDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        todayDecoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        markerDecoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        weekendTextStyle:
                                            TextStyle(color: Colors.grey),
                                        outsideDaysVisible: false,
                                      ),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: false,
                                        titleCentered: true,
                                        leftChevronIcon: Icon(
                                            Icons.chevron_left,
                                            color: Colors.red),
                                        rightChevronIcon: Icon(
                                            Icons.chevron_right,
                                            color: Colors.red),
                                        titleTextStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      daysOfWeekStyle: DaysOfWeekStyle(
                                        weekdayStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                        weekendStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 400,
                                  color: Colors.grey[200],
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (_selectedDay != null) ...[
                                          Text(
                                            'Slots for ${DateFormat('EEEE, MMMM d').format(_selectedDay!)}',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          _buildDateSpecificSlotsList(),
                                          SizedBox(height: 20),
                                          Center(
                                            child: GestureDetector(
                                              onTap: (_isLoading ||
                                                      _selectedDay == null ||
                                                      _isWeekend(_selectedDay!))
                                                  ? null
                                                  : () =>
                                                      _showAddTimeSlotDialog(),
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.easeInOut,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 14),
                                                decoration: BoxDecoration(
                                                  gradient: (_selectedDay !=
                                                              null &&
                                                          _isWeekend(
                                                              _selectedDay!))
                                                      ? LinearGradient(colors: const [
                                                          Colors.grey,
                                                          Colors.grey
                                                        ])
                                                      : LinearGradient(
                                                          colors: const [
                                                            Color(0xFF4CAF50),
                                                            Color(0xFF2E7D32)
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  boxShadow: (_selectedDay !=
                                                              null &&
                                                          !_isWeekend(
                                                              _selectedDay!))
                                                      ? [
                                                          BoxShadow(
                                                            color: Colors.green
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 12,
                                                            offset:
                                                                Offset(0, 6),
                                                          )
                                                        ]
                                                      : [],
                                                ),
                                                child: _isLoading
                                                    ? SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2,
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: const [
                                                          Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 22),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            'Add Time Slot',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
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

  Widget _buildNavItem(String text, double fontSize, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedText = text;
        });
        _navigateToScreen(text, context);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _selectedText == text
                  ? Color(0xFFFF0000)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            color: _selectedText == text ? Color(0xFFFF0000) : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSpecificSlotsList() {
    if (_selectedDay == null) {
      return Center(
          child: Text('Select a date to view slots',
              style: GoogleFonts.inter(color: Colors.grey)));
    }

    final normalizedDate =
        DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
    final slotsForDate = _dateSpecificSlots[normalizedDate];

    if (slotsForDate == null || slotsForDate.isEmpty) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 40, color: Colors.grey[400]),
              SizedBox(height: 8),
              Text(
                'No slots scheduled',
                style: GoogleFonts.inter(
                    color: Colors.grey[600], fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                'Tap "Add Time Slot" to create availability',
                style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
      ),
      child: ListView.builder(
        itemCount: slotsForDate.length,
        itemBuilder: (context, index) {
          final slot = slotsForDate[index];
          final slotKey =
              "${DateFormat('yyyy-MM-dd').format(normalizedDate)}|${slot.startTime}-${slot.endTime}";

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.access_time,
                            color: Colors.red, size: 18),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_formatTime(slot.startTime)} - ${_formatTime(slot.endTime)}",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Available for booking",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.delete_outline,
                          color: Colors.red, size: 20),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () => _deleteSlot(slotKey, normalizedDate, slot),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(String time) {
    try {
      if (time.contains('AM') || time.contains('PM')) {
        final cleanedTime = time.replaceAll(RegExp(r'[AP]M'), '').trim();
        final period = time.contains('AM') ? 'AM' : 'PM';
        final parts = cleanedTime.split(':');
        if (parts.length < 2) return time;
        return '${parts[0]}:${parts[1]} $period';
      }

      final parts = time.split(':');
      if (parts.length < 2) return time;

      final hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '$displayHour:${minute.padLeft(2, '0')} $period';
    } catch (e) {
      return time;
    }
  }

  Future<void> _deleteSlot(String slotKey, DateTime date, TimeSlot slot) async {
    int? slotId = _slotIdMapping[slotKey];
    if (slotId != null) {
      setState(() {
        _isLoading = true;
      });

      bool success = await ApiService.deleteTimeSlot(slotId);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        setState(() {
          _dateSpecificSlots[date]?.remove(slot);
          if (_dateSpecificSlots[date]?.isEmpty ?? false) {
            _dateSpecificSlots.remove(date);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Slot deleted successfully"),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to delete slot"),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToScreen(String screenName, BuildContext context) {
    Widget screen;

    switch (screenName) {
      case 'Request Schedules':
        screen = RequestScheduleScreen(coachAccount: widget.coachAccount,);
        break;
      case 'Reschedule Request':
        screen = RescheduleRequestScreen(coachAccount: widget.coachAccount,);
        break;
      case 'Schedules':
        screen = SchedulesScreen(coachAccount: widget.coachAccount,);
        break;
      default:
        screen = CoachScreen(coachAccount: widget.coachAccount,);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showAddTimeSlotDialog() {
    if (_selectedDay == null || _isWeekend(_selectedDay!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Time slots cannot be added on weekends"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    TimeOfDay? startTime;
    TimeOfDay? endTime;
    bool isProcessing = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              backgroundColor: Colors.white,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.access_time_rounded,
                            size: 32,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Create New Time Slot",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Select your available time for ${DateFormat('MMM d, yyyy').format(_selectedDay!)}",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 18, color: Colors.grey[700]),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('EEEE, MMMM d')
                                    .format(_selectedDay!),
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTimePickerRow(
                            context: context,
                            label: "Start Time",
                            selectedTime: startTime,
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Colors.green[700]!,
                                        onPrimary: Colors.white,
                                        surface: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      timePickerTheme: TimePickerThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (time != null) {
                                setState(() {
                                  startTime = time;
                                  endTime = TimeOfDay(
                                    hour: time.hour + (time.minute + 30) ~/ 60,
                                    minute: (time.minute + 30) % 60,
                                  );
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTimePickerRow(
                            context: context,
                            label: "End Time",
                            selectedTime: endTime,
                            isDisabled: startTime == null,
                            defaultText: startTime == null
                                ? "Select start time first"
                                : "30 min after start",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Students will be able to book appointments during this time slot.",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isProcessing
                                ? null
                                : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: Colors.grey[400]!,
                                width: 1,
                              ),
                              foregroundColor: Colors.grey[700],
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (isProcessing || startTime == null)
                                ? null
                                : () async {
                                    setState(() => isProcessing = true);
                                    try {
                                      if (_userId == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("User not authenticated"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      // Create the new time slot
                                      final newSlot = TimeSlot(
                                        id: 0,
                                        coachId: 0, // Will be set by backend
                                        day: DateFormat('EEEE')
                                            .format(_selectedDay!),
                                        dateSlot: DateFormat('yyyy-MM-dd')
                                            .format(_selectedDay!),
                                        startTime:
                                            '${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}:00',
                                        endTime:
                                            '${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}:00',
                                        clickable: true,
                                        status: '',
                                      );

                                      TimeSlot? createdSlot =
                                          await ApiService.createTimeSlot(
                                              newSlot, _userId!);
                                      if (createdSlot != null && mounted) {
                                        Navigator.pop(context);
                                        await _refreshSlots();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Time slot added successfully"),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Failed to add time slot: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } finally {
                                      if (mounted) {
                                        setState(() => isProcessing = false);
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: isProcessing
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Add Slot",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimePickerRow({
    required BuildContext context,
    required String label,
    TimeOfDay? selectedTime,
    String? defaultText,
    bool isDisabled = false,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDisabled ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: isDisabled ? null : onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[100] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDisabled ? Colors.grey[300]! : Colors.grey[400]!,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime != null
                        ? selectedTime.format(context)
                        : defaultText ?? "Select Time",
                    style: GoogleFonts.inter(
                      color: selectedTime != null
                          ? Colors.black87
                          : Colors.grey[600],
                      fontWeight: selectedTime != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    size: 18,
                    color: isDisabled ? Colors.grey[400] : Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
