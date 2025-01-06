import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PendingSection extends StatelessWidget {
  final double screenWidth;

  PendingSection({required this.screenWidth});

  Future<List<Map<String, String>>> fetchPendingRequests() async {
    const url = 'http://localhost/scheduling/api/read_pending.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['status'] == 'success') {
          final data = decodedResponse['data'] as List;
          return data.map<Map<String, String>>((json) {
            return {
              'name': json['name'],
              'program': json['program'],
              'date': json['date'],
              'time': json['time'],
            };
          }).toList();
        } else {
          throw Exception('Failed to load pending requests');
        }
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      print('Error fetching pending requests: $e');
      throw Exception('Error fetching pending requests');
    }
  }

  String getProgramName(String programId) {
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
    return FutureBuilder<List<Map<String, String>>>(
      future: fetchPendingRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No pending requests found.'));
        } else {
          final requests = snapshot.data!;
          return screenWidth < 600
              ? ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return buildRequestCard(request);
                  },
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3.9,
                  ),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return buildRequestCard(request);
                  },
                );
        }
      },
    );
  }

  Widget buildRequestCard(Map<String, String> request) {
    String formattedDate =
        DateFormat('yyyy/MM/dd').format(DateTime.parse(request['date'] ?? ''));
    String formattedTime = DateFormat('hh:mm a')
        .format(DateTime.parse("2000-01-01T${request['time'] ?? '00:00:00'}"));

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request['name'] ?? '',
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                "Program Requested: ${getProgramName(request['program'] ?? '')}",
                style: GoogleFonts.inter(fontSize: 14)),
            Text("Date: $formattedDate",
                style: GoogleFonts.inter(fontSize: 14)),
            Text("Time: $formattedTime",
                style: GoogleFonts.inter(fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Buttons aligned to the right
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle Decline button click
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color.fromARGB(255, 90, 90, 90),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8), // Rounded corners
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 20, vertical: 12), // Padding
                //   ),
                //   child: const Text(
                //     "Decline",
                //     style: TextStyle(color: Colors.white), // Text color white
                //   ),
                // ),
                const SizedBox(width: 8), // Small space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Handle Accept button click
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFEC1D25), // Red color for Accept
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(color: Colors.white), // Text color white
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
