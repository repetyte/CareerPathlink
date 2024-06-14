import 'package:flutter/material.dart';

class DocumentSubmissionScreen extends StatelessWidget {
  const DocumentSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Your Documents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Add more form fields as needed
            ElevatedButton(
              onPressed: () {
                // Handle document submission
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
