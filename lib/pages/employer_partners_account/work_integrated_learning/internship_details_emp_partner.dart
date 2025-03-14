import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/pages/employer_partners_account/work_integrated_learning/update_internhsip.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDetailsPartner extends StatefulWidget {
  InternshipWithPartner internshipWithPartner; // Remove final keyword
  final IndustryPartnerAccount employerPartnerAccount;

  InternshipDetailsPartner({super.key, required this.internshipWithPartner, required this.employerPartnerAccount});

  @override
  _InternshipDetailsPartnerState createState() => _InternshipDetailsPartnerState();
}

class _InternshipDetailsPartnerState extends State<InternshipDetailsPartner> {
  final InternshipApiService internshipApiService = InternshipApiService();
  late Future<List<Internship>> futureInternships;

  @override
  void initState() {
    debugPrint(
        'Employer Partner ID: ${widget.employerPartnerAccount.partnerName}');
    debugPrint('Employer Partner Location: ${widget.employerPartnerAccount.partnerLocation}\n');
    super.initState();

    futureInternships = internshipApiService.fetchInternships();
  }

  void _refreshInternships() {
    setState(() {
      futureInternships = internshipApiService.fetchInternships();
    });
  }

  void _updateInternship(IndustryPartnerAccount employerPartnerAccount) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateInternship(
        internshipWithPartner: widget.internshipWithPartner,
        onInternshipUpdated: _refreshInternships,
        employerPartnerAccount: widget.employerPartnerAccount,
      );
    })).then((updatedInternship) {
      if (updatedInternship != null) {
        setState(() {
          widget.internshipWithPartner = updatedInternship; // Update the internship details
          futureInternships = internshipApiService.fetchInternships(); // Refresh internship postings
        });
      }
    });
  }

  void _deleteInternship(int? internshipId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Internship',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content:
              const Text('Are you sure you want to delete this internship? All applications from this internship will be deleted.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (internshipId != null) {
                  internshipApiService.deleteInternship(internshipId).then((_) {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pop(true); // Navigate back and refresh
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Internship deleted successfully.')),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to delete internship: $error')),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid Internship ID')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship Details'),
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
                            'assets/images/${widget.internshipWithPartner.displayPhoto}',
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
                                            widget.internshipWithPartner.internshipTitle,
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
                                    widget.internshipWithPartner.hours,
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
                        Text(widget.internshipWithPartner.takehomePay,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Location: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.location,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Required Skills: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.requiredSkills,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Qualifications: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.qualifications,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('Description: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.description,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),

                        const Text('About Employer: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.partnerName.toString(),
                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )),
                            const SizedBox(height: 4),
                        Text(widget.internshipWithPartner.partnerLocation.toString(),
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
                            onPressed: () =>
                                _deleteInternship(widget.internshipWithPartner.internshipId),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete Internship'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () =>
                                _updateInternship(widget.employerPartnerAccount),
                            icon: const Icon(Icons.update),
                            label: const Text('Update Internship'),
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
