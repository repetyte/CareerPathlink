import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployedListsDepartmentDean extends StatefulWidget {
  final String departmentName;

  const EmployedListsDepartmentDean({super.key, required this.departmentName});

  @override
  _EmployedListsDepartmentDeanState createState() =>
      _EmployedListsDepartmentDeanState();
}

class _EmployedListsDepartmentDeanState extends State<EmployedListsDepartmentDean> {
  List employed = [];
  final controllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    fetchEmployed();
  }

  Future<void> fetchEmployed() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/CareerPathlink/api/employed/read_employed.php'));
      if (response.statusCode == 200) {
        setState(() {
          employed = json.decode(response.body);
        });
      } else {
        print('Failed to fetch employed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching employed: $e');
    }
  }

  Future<void> deleteEmployed(String studentNo) async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost/delete_employed.php?student_no=$studentNo'));
      if (response.statusCode == 200) {
        setState(() {
          employed.removeWhere((employee) => employee['student_no'] == studentNo);
        });
      } else {
        print('Failed to delete employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }

  Future<void> updateEmployed(String studentNo) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/update_employed.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'student_no': controllers['student_no']!.text,
          'last_name': controllers['last_name']!.text,
          'first_name': controllers['first_name']!.text,
          'middle_name': controllers['middle_name']!.text,
          'birthdate': controllers['birthdate']!.text,
          'age': int.tryParse(controllers['age']!.text) ?? 0,
          'home_address': controllers['home_address']!.text,
          'unc_email': controllers['unc_email']!.text,
          'personal_email': controllers['personal_email']!.text,
          'facebook_name': controllers['facebook_name']!.text,
          'employer_name': controllers['employer_name']!.text,
          'position': controllers['position']!.text,
          'start_date': controllers['start_date']!.text,
        }),
      );
      if (response.statusCode == 200) {
        fetchEmployed();
      } else {
        print('Failed to update employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating employee: $e');
    }
  }

  Future<void> createEmployed() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/create_employed.php'),
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
          'employer_name': controllers['employer_name']?.text,
          'position': controllers['position']?.text,
          'start_date': controllers['start_date']?.text,
        }),
      );
      if (response.statusCode == 200) {
        fetchEmployed();
      } else {
        print('Failed to create employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating employee: $e');
    }
  }

  void showUpdateDialog(Map<String, dynamic> employee) {
    controllers.clear();
    employee.forEach((key, value) {
      controllers[key] = TextEditingController(text: value?.toString() ?? '');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Employee'),
          content: SingleChildScrollView(
            child: Column(
              children: controllers.keys.map((key) {
                return TextField(
                  controller: controllers[key],
                  decoration: InputDecoration(
                      labelText: key.replaceAll('_', ' ').toUpperCase()),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                updateEmployed(employee['student_no']);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showCreateDialog() {
    controllers.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Employee'),
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
                  'employer_name',
                  'position',
                  'start_date',
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
                createEmployed();
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
      body: employed.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Student No')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Employer')),
                  DataColumn(label: Text('Position')),
                  DataColumn(label: Text('Start Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: employed.map((employee) {
                  return DataRow(cells: [
                    DataCell(Text(employee['student_no'])),
                    DataCell(Text(
                        '${employee['first_name']} ${employee['last_name']}')),
                    DataCell(Text(employee['employer_name'])),
                    DataCell(Text(employee['position'])),
                    DataCell(Text(employee['start_date'] ?? 'N/A')),
                    // DataCell(Row(
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(Icons.edit),
                    //       onPressed: () => showUpdateDialog(employee),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.delete),
                    //       onPressed: () =>
                    //           deleteEmployed(employee['student_no']),
                    //     ),
                    //   ],
                    // )),
                  ]);
                }).toList(),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: showCreateDialog,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
