import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDetailsPartner extends StatefulWidget {
  final InternshipWithPartner internship;
  final IndustryPartnerAccount employerPartnerAccount;

  const InternshipDetailsPartner({super.key, required this.internship, required this.employerPartnerAccount});

  @override
  _InternshipDetailsPartnerState createState() => _InternshipDetailsPartnerState();
}

class _InternshipDetailsPartnerState extends State<InternshipDetailsPartner> {
  final InternshipApiService internshipApiService = InternshipApiService();

  @override
  void initState() {
    debugPrint(
        'Employer Partner ID: ${widget.employerPartnerAccount.partnerName}');
    debugPrint('Employer Partner Location: ${widget.employerPartnerAccount.partnerLocation}\n');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            widget.internship.displayPhoto,
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
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
                              decoration: const BoxDecoration(
                                color: Color(0x80000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: const SizedBox(
                                width: 380,
                                height: 188,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 64, 16, 64),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.internship.internshipTitle,
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {// Call the API to apply for the internship
                                          },
                                          child: const Text('Internship Applications'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.internship.hours,
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      // fontSize: 14,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('TakeHome Pay: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.takehomePay,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Location: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.location,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Required Skills: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.requiredSkills,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Qualifications: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.qualifications,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Description: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.description,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('About Employer: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internship.partnerName.toString(),
                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )),
                            const SizedBox(height: 4),
                        Text(widget.internship.partnerLocation.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () 
                            {},
                            // => _deleteJobPosting(
                            //     widget.jobPostingWithPartner.jobId),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete Job'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () 
                            {},
                            // =>
                            //     _updateJobPosting(widget.jobPostingWithPartner),
                            icon: const Icon(Icons.update),
                            label: const Text('Update Job'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
