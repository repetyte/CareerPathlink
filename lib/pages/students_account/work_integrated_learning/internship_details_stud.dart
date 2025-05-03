import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/pages/students_account/work_integrated_learning/internship_student_application.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDetailsStud extends StatefulWidget {
  final StudentAccount studentAccount;
  final InternshipWithPartner internshipWithPartner;

  const InternshipDetailsStud({
    super.key,
    required this.internshipWithPartner,
    required this.studentAccount,
  });

  @override
  _InternshipDetailsStudState createState() => _InternshipDetailsStudState();
}

class _InternshipDetailsStudState extends State<InternshipDetailsStud> {
  final InternshipApiService internshipApiService = InternshipApiService();

  Widget _buildInternshipHeader() {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
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
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side - Internship Title
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topLeft,
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
                        ),
                        const SizedBox(width: 20),
                        // Right side - Internship Description
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.internshipWithPartner.description,
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
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
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.internshipWithPartner.description,
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
    );
  }

  Widget _buildInternshipDetails() {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Location to Qualifications
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLocationSection(),
                  const SizedBox(height: 24),
                  _buildRequiredSkillsSection(),
                  const SizedBox(height: 24),
                  _buildQualificationsSection(),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Right column - Hours to About Employer
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHoursSection(),
                  const SizedBox(height: 24),
                  _buildAllowanceSection(),
                  const SizedBox(height: 24),
                  _buildAboutEmployerSection(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationSection(),
            const SizedBox(height: 24),
            _buildRequiredSkillsSection(),
            const SizedBox(height: 24),
            _buildQualificationsSection(),
            const SizedBox(height: 24),
            _buildHoursSection(),
            const SizedBox(height: 24),
            _buildAllowanceSection(),
            const SizedBox(height: 24),
            _buildAboutEmployerSection(),
          ],
        ),
      );
    }
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.location,
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildRequiredSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Required Skills: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.requiredSkills,
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildQualificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Qualifications: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.qualifications,
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hours: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.hours,
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildAllowanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('WIL Allowance: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.takehomePay,
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildAboutEmployerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About Employer: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.partnerName.toString(),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.internshipWithPartner.partnerLocation.toString(),
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildApplyButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topRight,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InternshipApplicationScreen(
                  internshipWithPartner: widget.internshipWithPartner,
                  studentAccount: widget.studentAccount,
                ),
              ),
            );
          },
          icon: const Icon(Icons.send),
          label: const Text('Submit Application'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIL Opportunity Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInternshipHeader(),
                _buildInternshipDetails(),
                _buildApplyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}