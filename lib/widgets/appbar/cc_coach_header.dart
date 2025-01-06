import 'package:flutter/material.dart';
import 'package:flutter_app/pages/students_account/career_coaching/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  // Function to launch Google Maps
  Future<void> _launchGoogleMaps() async {
    const String googleMapsUrl =
        'https://www.google.com/maps/place/University+Of+Nueva+Caceres/@13.6245313,123.1825038,16.95z/data=!4m6!3m5!1s0x33a18cb17fc9a129:0x3bc323a37f0bd148!8m2!3d13.6245666!4d123.182528!16zL20vMGZ6eDlj?hl=en&entry=ttu&g_ep=EgoyMDI0MTEyNC4xIKXMDSoASAFQAw%3D%3D'; // Google Maps URL for UNC
    final Uri url = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  // Function to launch email client
  Future<void> _launchEmail(String email) async {
    final Uri emailUrl = Uri.parse('mailto:$email');
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      throw 'Could not launch email client';
    }
  }

  // Function to copy text to clipboard
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // Optionally show a snack bar to indicate the text was copied
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('logo.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UNC',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Career',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                          255,
                                          114,
                                          114,
                                          114,
                                        ), // Gray color
                                      ),
                                    ),
                                    SizedBox(width: 0),
                                    Text(
                                      'Pathlink',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0xFFEC1D25), // Red color
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none, color: Colors.black),
                    iconSize: 30.0,
                    onPressed: () {
                      // Define action for bell icon here
                    },
                  ),
                  PopupMenuButton<int>(
                    padding: EdgeInsets.zero,
                    offset: Offset(0, 40),
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),
                    onSelected: (value) {
                      // Navigate to CareerCenter if "Switch account" is selected
                      if (value == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                      // Handle other selections here (e.g., Logout)
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text("Switch account"),
                      ),
                      PopupMenuItem(value: 2, child: Text("Logout")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: _launchGoogleMaps, // Launch Google Maps on tap
                  child: _buildContactInfo(
                    icon: Icons.location_on,
                    text: 'J. Hernandez Ave, Naga City 4400',
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _launchEmail(
                    'info@unc.edu.ph',
                  ), // Launch email client
                  child: _buildContactInfo(
                    icon: Icons.email,
                    text: 'info@unc.edu.ph',
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _copyToClipboard('(054) 472-1862 loc. 130'),
                  child: _buildContactInfo(
                    icon: Icons.phone,
                    text: '(054) 472-1862 loc. 130',
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _copyToClipboard('0907-156-6898'),
                  child: _buildContactInfo(
                    icon: Icons.phone,
                    text: '0907-156-6898',
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _copyToClipboard('22565-1-862'),
                  child: _buildContactInfo(
                    icon: Icons.sms,
                    text: '22565-1-862',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFEC1D25), size: 24),
        SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
