// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/career_coaching/student_profile_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'information_form.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../widgets/appbar/student_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'footer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Slot model
class Slot {
  final int id;
  final int coachId;
  final String date;
  final String time;
  final String status; // 'available' or 'booked'

  Slot({
    required this.id,
    required this.coachId,
    required this.date,
    required this.time,
    required this.status,
  });

  // Factory method to create a Slot from JSON
  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'],
      coachId: json['coach_id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}

// API Service to fetch available slots
class ApiService {
  static const String baseUrl =
      'http://localhost/UNC-CareerPathlink/api/career_coaching'; // Replace with your actual API URL

  // Fetch available slots for a selected coach
  static Future<List<Slot>> fetchAvailableSlots(int coachId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_slots.php?coach_id=$coachId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Slot.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load available slots');
      }
    } catch (e) {
      rethrow;
    }
  }

  static uploadCV(String studentNo, List<int> list, String s) {}

  static addAppointment(Map<String, Object?> appointmentData) {}

  static updateStudent(Student updatedStudent) {}

  static fetchUpcomingSessions() {}

  static fetchPastSessions() {}

  static fetchStudent(String s) {}

  static fetchInProcessAppointments() {}

  static fetchCompletedAppointments() {}

  // static Future<List<Map<String, dynamic>>> fetchYearLevelInsights() {}

  // static Future<List<Map<String, dynamic>>> fetchGenderDistribution() {}


}

// Calendar Screen
class CalendarScreen extends StatefulWidget {
  final int coachId;

  const CalendarScreen({super.key, required this.coachId});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;
  final double headerFontSize = 16.0;

  // Fetch available slots for the selected coach
  Future<List<Slot>> fetchSlots() async {
    return await ApiService.fetchAvailableSlots(widget.coachId);
  }

  @override
  Widget build(BuildContext context) {
    bool isWebScreen =
        MediaQuery.of(context).size.width > 800; // Detecting web screen size

    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          const Divider(
            color: Color.fromARGB(255, 238, 233, 233),
            thickness: 2.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isWebScreen
                            ? Row(
                                children: [
                                  // Left side: Calendar
                                  Expanded(
                                    flex: 1,
                                    child: TableCalendar(
                                      firstDay: DateTime.utc(2020, 1, 1),
                                      lastDay: DateTime.utc(2030, 12, 31),
                                      focusedDay: focusedDay,
                                      selectedDayPredicate: (day) =>
                                          isSameDay(selectedDate, day),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        setState(() {
                                          selectedDate = selectedDay;
                                          this.focusedDay = focusedDay;
                                        });
                                      },
                                      calendarStyle: CalendarStyle(
                                        todayDecoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 241, 20, 20),
                                          shape: BoxShape.circle,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 241, 20, 20),
                                          shape: BoxShape.circle,
                                        ),
                                        defaultTextStyle:
                                            GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        todayTextStyle: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: false,
                                        titleCentered: true,
                                        leftChevronIcon: Icon(
                                          FontAwesomeIcons.angleDoubleLeft,
                                        ),
                                        rightChevronIcon: Icon(
                                          FontAwesomeIcons.angleDoubleRight,
                                        ),
                                        titleTextStyle: GoogleFonts.montserrat(
                                          fontSize: headerFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Right side: Available slots
                                  Expanded(
                                    flex: 1,
                                    child: FutureBuilder<List<Slot>>(
                                      future: fetchSlots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('No slots available.'));
                                        }

                                        final slots = snapshot.data!;
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 12.0),
                                            constraints: BoxConstraints(
                                              maxWidth: isWebScreen
                                                  ? 400
                                                  : double.infinity,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_today,
                                                        size: 16),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      selectedDate != null
                                                          ? DateFormat(
                                                                  'MMMM dd, yyyy')
                                                              .format(
                                                                  selectedDate!)
                                                          : DateFormat(
                                                                  'MMMM dd, yyyy')
                                                              .format(DateTime
                                                                  .now()),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  'Available Slots:',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Wrap(
                                                  spacing: 8.0,
                                                  runSpacing: 8.0,
                                                  children: slots.map((slot) {
                                                    final isAvailable =
                                                        slot.status ==
                                                            'available';
                                                    final time = DateFormat(
                                                            'h:mm a')
                                                        .format(DateFormat(
                                                                'HH:mm:ss')
                                                            .parse(slot.time));

                                                    return GestureDetector(
                                                      onTap: isAvailable
                                                          ? () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          StudentInformationScreen(
                                                                    coach:
                                                                        'Coach Name',
                                                                    dateTime:
                                                                        time,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          : null,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    12.0,
                                                                vertical: 8.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isAvailable
                                                              ? Colors.green[50]
                                                              : Colors.red[50],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: isAvailable
                                                                ? Colors.green
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          time,
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isAvailable
                                                                ? Colors.green
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  // Mobile view: Calendar and available slots
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TableCalendar(
                                      firstDay: DateTime.utc(2020, 1, 1),
                                      lastDay: DateTime.utc(2030, 12, 31),
                                      focusedDay: focusedDay,
                                      selectedDayPredicate: (day) =>
                                          isSameDay(selectedDate, day),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        setState(() {
                                          selectedDate = selectedDay;
                                          this.focusedDay = focusedDay;
                                        });
                                      },
                                      calendarStyle: CalendarStyle(
                                        todayDecoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 241, 20, 20),
                                          shape: BoxShape.circle,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 241, 20, 20),
                                          shape: BoxShape.circle,
                                        ),
                                        defaultTextStyle:
                                            GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        todayTextStyle: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: false,
                                        titleCentered: true,
                                        leftChevronIcon: Icon(
                                          FontAwesomeIcons.angleDoubleLeft,
                                        ),
                                        rightChevronIcon: Icon(
                                          FontAwesomeIcons.angleDoubleRight,
                                        ),
                                        titleTextStyle: GoogleFonts.montserrat(
                                          fontSize: headerFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Slot list for mobile view
                                  FutureBuilder<List<Slot>>(
                                    future: fetchSlots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text('No slots available.'));
                                      }

                                      final slots = snapshot.data!;
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 12.0),
                                          constraints: BoxConstraints(
                                            maxWidth: isWebScreen
                                                ? 400
                                                : double.infinity,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_today,
                                                      size: 16),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    selectedDate != null
                                                        ? DateFormat(
                                                                'MMMM dd, yyyy')
                                                            .format(
                                                                selectedDate!)
                                                        : DateFormat(
                                                                'MMMM dd, yyyy')
                                                            .format(
                                                                DateTime.now()),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                'Available Slots:',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 8.0,
                                                runSpacing: 8.0,
                                                children: slots.map((slot) {
                                                  final isAvailable =
                                                      slot.status ==
                                                          'available';
                                                  final time = DateFormat(
                                                          'h:mm a')
                                                      .format(DateFormat(
                                                              'HH:mm:ss')
                                                          .parse(slot.time));

                                                  return GestureDetector(
                                                    onTap: isAvailable
                                                        ? () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        StudentInformationScreen(
                                                                  coach:
                                                                      'Coach Name',
                                                                  dateTime:
                                                                      time,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        : null,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12.0,
                                                          vertical: 8.0),
                                                      decoration: BoxDecoration(
                                                        color: isAvailable
                                                            ? Colors.green[50]
                                                            : Colors.red[50],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: isAvailable
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        time,
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: isAvailable
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 95),
                    ],
                  ),
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
