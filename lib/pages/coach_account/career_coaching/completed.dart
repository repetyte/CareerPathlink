import 'package:flutter/material.dart';
import 'package:flutter_app/pages/students_account/career_coaching/calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class Completed extends StatelessWidget {
  const Completed({super.key});

  // Function to get the program name based on the program ID
  String getProgramName(String? programId) {
    if (programId == null) return 'Unknown Program'; // Handle null programId
    switch (programId) {
      case '1':
        return 'Career Coaching';
      case '2':
        return 'Mock Interview';
      case '3':
        return 'CV Review';
      case '4':
        return 'Mentoring';
      default:
        return 'Unknown Program';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService.fetchCompletedAppointments(), // Call the API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> completedRequests = snapshot.data!;

          return completedRequests.isEmpty
              ? Center(child: Text('No completed requests found'))
              : MediaQuery.of(context).size.width < 600
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: completedRequests.length,
                      itemBuilder: (context, index) {
                        final request = completedRequests[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    request["name"] ??
                                        'No Name', // Check for null
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Program: ${getProgramName(request["program_request"])}",
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                  Text(
                                    "Date: ${request["date_request"] != null ? DateFormat('yyyy/MM/dd').format(DateTime.parse(request["date_request"])) : 'No Date'}",
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                  Text(
                                    "Time: ${request["time_request"] != null ? DateFormat('hh:mm a').format(DateTime.parse("2000-01-01T${request["time_request"]}")) : 'No Time'}",
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle action for completed request
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 45, 76, 162),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          "Completed",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 3.9,
                      ),
                      itemCount: completedRequests.length,
                      itemBuilder: (context, index) {
                        final request = completedRequests[index];
                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request["name"] ??
                                      'No Name', // Check for null
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Program: ${getProgramName(request["program_request"])}",
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                                Text(
                                  "Date: ${request["date_request"] != null ? DateFormat('yyyy/MM/dd').format(DateTime.parse(request["date_request"])) : 'No Date'}",
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                                Text(
                                  "Time: ${request["time_request"] != null ? DateFormat('hh:mm a').format(DateTime.parse("2000-01-01T${request["time_request"]}")) : 'No Time'}",
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle action for completed request
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 45, 76, 162),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Completed",
                                        style: TextStyle(color: Colors.white),
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
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}
