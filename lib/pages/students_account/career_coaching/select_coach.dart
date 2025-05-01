import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'calendar.dart';
// Import the footer widget

class SelectCoachScreen extends StatefulWidget {
  final StudentAccount studentAccount;
  const SelectCoachScreen({super.key, required this.studentAccount});

  @override
  _SelectCoachScreenState createState() => _SelectCoachScreenState();
}

class _SelectCoachScreenState extends State<SelectCoachScreen> {
  List<dynamic> _coaches = [];
  bool _isLoading = true;
  String _selectedRole = 'All'; // Default role is 'All'
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCoaches();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> fetchCoaches() async {
    const url =
        'http://localhost/UNC-CareerPathlink/api/career_coaching/get_coaches.php'; // Replace with your server address
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _coaches = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showError('Error fetching coaches: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showError('Error fetching coaches: $e');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start an Appointment'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedRole,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedRole = newValue!;
                                  });
                                },
                                items: <String>[
                                  'All',
                                  'Executive Coach',
                                  'Interview Expert',
                                  'CV Specialist',
                                  'Career Advisor',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.montserrat(
                                        fontSize: screenWidth < 600 ? 11 : 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 4,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search Coach',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.mic,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _coaches.isEmpty
                          ? const Center(child: Text('No coaches available.'))
                          : Builder(
                              builder: (context) {
                                List<dynamic> filteredCoaches =
                                    _coaches.where((coach) {
                                  return (_selectedRole == 'All' ||
                                          coach['role'] == _selectedRole) &&
                                      coach['name'].toLowerCase().contains(
                                          searchController.text.toLowerCase());
                                }).toList();

                                return filteredCoaches.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: SizedBox(
                                          height:
                                              400, // Adjust the height as needed to keep space consistent
                                          child: Center(
                                            child: Text(
                                              'No result found',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: SizedBox(
                                          height:
                                              400, // Maintain the same height as the empty state
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: filteredCoaches.length,
                                            itemBuilder: (context, index) {
                                              final coach =
                                                  filteredCoaches[index];
                                              int coachId = 0;
                                              try {
                                                coachId = int.parse(coach[
                                                    'id']); // Convert id to int
                                              } catch (e) {
                                                debugPrint(
                                                    'Invalid coach id: ${coach['id']}');
                                              }
                                              return _buildCoachTile(
                                                coach['name'] ??
                                                    'Unknown Coach',
                                                coach['role'] ?? 'Unknown Role',
                                                coach['imageUrl'] ?? '',
                                                context,
                                                coachId, // Pass the parsed int value
                                              );
                                            },
                                          ),
                                        ),
                                      );
                              },
                            ), // Reusable Footer widget
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Coach Card Builder
  Widget _buildCoachTile(
    String name,
    String role,
    String imageUrl,
    BuildContext context,
    int coachId, // Add the coachId to the function parameters
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0), // Adjusted vertical padding for less space
      child: Card(
        margin: const EdgeInsets.symmetric(
            vertical: 4.0), // Reduced vertical margin between cards
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Coach image
              ClipOval(
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300],
                        child:
                            Icon(Icons.person, size: 30, color: Colors.white),
                      ),
              ),
              const SizedBox(width: 16.0), // Space between image and text
              // Text details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth < 600 ? 14.0 : 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    role,
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth < 600 ? 12.0 : 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Spacer(), // Spacer between the text and button
              // Book now button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 225, 17, 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarScreen(
                        coachId: coachId,
                        studentAccount: widget.studentAccount,
                      ), // Pass coachId here
                    ),
                  );
                },
                child: Text(
                  'Book now',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth < 600 ? 14.0 : 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
