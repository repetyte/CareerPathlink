import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/graduates_tracer_industry/GraduatesLists.dart';
import 'package:flutter_app/services/graduates_lists_api_service.dart';
import 'package:http/http.dart' as http;

class GraduatesListsDepartmentDirector extends StatefulWidget {
  final String departmentName;

  const GraduatesListsDepartmentDirector({super.key, required this.departmentName});

  @override
  _GraduatesListsDepartmentDirectorState createState() =>
      _GraduatesListsDepartmentDirectorState();
}

class _GraduatesListsDepartmentDirectorState extends State<GraduatesListsDepartmentDirector> {
  late Future<List<GraduatesList>> futureGraduatesLists;
  final GraduatesListApiService apiService = GraduatesListApiService();
  final controllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    futureGraduatesLists = apiService.fetchGraduatesList();
  }

  Future<void> createGraduate() async {
    try {
      // Validate input fields
      if (controllers.values.any((controller) => controller.text.isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')),
        );
        return;
      }

      final response = await http.post(
        Uri.parse('http://localhost/graduates_tracer/api/graduates/create.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'student_no': controllers['student_no']?.text,
          'last_name': controllers['last_name']?.text,
          'first_name': controllers['first_name']?.text,
          'middle_name': controllers['middle_name']?.text,
          'birthdate': controllers['birthdate']?.text,
          'age': int.tryParse(controllers['age']?.text ?? '0') ?? 0,
          'home_address': controllers['home_address']?.text,
          'unc_email': controllers['unc_email']?.text,
          'personal_email': controllers['personal_email']?.text,
          'facebook_name': controllers['facebook_name']?.text,
          'course': controllers['course']?.text,
          '1st_target_employer': controllers['1st_target_employer']?.text,
          '2nd_target_employer': controllers['2nd_target_employer']?.text,
          '3rd_target_employer': controllers['3rd_target_employer']?.text,
          'graduation_date': controllers['graduation_date']?.text,
        }),
      );

      if (response.statusCode == 200) {
        final newGraduate = GraduatesList.fromJson(jsonDecode(response.body));

        setState(() {
          futureGraduatesLists = futureGraduatesLists.then((list) {
            final updatedList = List<GraduatesList>.from(list);
            updatedList.add(newGraduate);
            return updatedList;
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Graduate created successfully!')),
        );
      } else {
        print('Failed to create graduate: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create graduate')),
        );
      }
    } catch (e) {
      print('Error creating graduate: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while creating graduate')),
      );
    }
  }

  void showCreateDialog() {
    controllers.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Graduate'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (String key in [
                  'student_no',
                  'last_name',
                  'first_name',
                  'middle_name',
                  'birthdate',
                  'age',
                  'home_address',
                  'unc_email',
                  'personal_email',
                  'facebook_name',
                  'course',
                  '1st_target_employer',
                  '2nd_target_employer',
                  '3rd_target_employer',
                  'graduation_date'
                ])
                  TextField(
                    controller: controllers[key] = TextEditingController(),
                    decoration: InputDecoration(
                        labelText: key.replaceAll('_', ' ').toUpperCase()),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                createGraduate();
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
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
        title: Text(widget.departmentName),
      ),
      body: FutureBuilder<List<GraduatesList>>(
        future: futureGraduatesLists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No graduates found.'));
          }

          final graduates = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Student No')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Middle Name')),
                DataColumn(label: Text('Birthdate')),
                DataColumn(label: Text('Age')),
                DataColumn(label: Text('Home Address')),
                DataColumn(label: Text('UNC Email')),
                DataColumn(label: Text('Personal Email')),
                DataColumn(label: Text('Facebook Name')),
                DataColumn(label: Text('Course')),
                DataColumn(label: Text('1st Target Employer')),
                DataColumn(label: Text('2nd Target Employer')),
                DataColumn(label: Text('3rd Target Employer')),
                DataColumn(label: Text('Graduation Date')),
                DataColumn(label: Text('Actions')),
              ],
              rows: graduates.map((graduate) {
                return DataRow(cells: [
                  DataCell(Text(graduate.studentNo?.toString() ?? 'N/A')),
                  DataCell(Text(graduate.lastName ?? 'N/A')),
                  DataCell(Text(graduate.firstName ?? 'N/A')),
                  DataCell(Text(graduate.middleName ?? 'N/A')),
                  DataCell(Text(graduate.birthdate?.toIso8601String() ?? 'N/A')),
                  DataCell(Text(graduate.age?.toString() ?? 'N/A')),
                  DataCell(Text(graduate.homeAddress ?? 'N/A')),
                  DataCell(Text(graduate.uncEmail ?? 'N/A')),
                  DataCell(Text(graduate.personalEmail ?? 'N/A')),
                  DataCell(Text(graduate.facebookName ?? 'N/A')),
                  DataCell(Text(graduate.course ?? 'N/A')),
                  DataCell(Text(graduate.firstTargetEmployer ?? 'N/A')),
                  DataCell(Text(graduate.secondTargetEmployer ?? 'N/A')),
                  DataCell(Text(graduate.thirdTargetEmployer ?? 'N/A')),
                  DataCell(Text(graduate.graduationDate?.toIso8601String() ?? 'N/A')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement update logic here
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Implement delete logic here
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
