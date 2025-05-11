import 'package:flutter/material.dart';

class GraduatesTrackerDean extends StatelessWidget {
  const GraduatesTrackerDean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graduates Tracker'),
      ),
      body: Column(
        children: [
          // Title Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.grey[300],
            child: const Text(
              'TOTAL AVERAGE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Rectangular Containers
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                categoryContainer(
                  title: '(BETA) IPO Summarized Sheet',
                  imagePath: 'assets/ipo_sheet_image.png',
                ),
                categoryContainer(
                  title: 'Automated IPO Tracker PER Department',
                  imagePath: 'assets/ipo_tracker_department.png',
                ),
                categoryContainer(
                  title: 'Automated IPO Tracker (Consolidated)',
                  imagePath: 'assets/ipo_tracker_consolidated.png',
                ),
                categoryContainer(
                  title: 'KPI Delivery Tool (Key Points vs Colleges)',
                  imagePath: 'assets/kpi_colleges.png',
                ),
                categoryContainer(
                  title: 'KPI Delivery Tool (Key Points vs WDT Trainers)',
                  imagePath: 'assets/kpi_trainers.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryContainer({required String title, required String imagePath}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
