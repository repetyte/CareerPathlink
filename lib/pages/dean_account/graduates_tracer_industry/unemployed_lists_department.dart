import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UnemployedListsDepartmentDean extends StatefulWidget {
  final String departmentName;

  const UnemployedListsDepartmentDean({super.key, required this.departmentName});

  @override
  _UnemployedListsDepartmentDeanState createState() =>
      _UnemployedListsDepartmentDeanState();
}

class _UnemployedListsDepartmentDeanState
    extends State<UnemployedListsDepartmentDean> {
  List unemployedLists = [];
  final controllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    fetchUnemployedLists();
  }

  Future<void> fetchUnemployedLists() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1/unemployed_read.php'));
      if (response.statusCode == 200) {
        setState(() {
          unemployedLists = json.decode(response.body);
        });
      } else {
        print(
            'Failed to fetch unemployed lists. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching unemployed lists: $e');
    }
  }

  Future<void> deleteUnemployed(String studentNo) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/unemployed_delete.php?student_no=$studentNo'));
      if (response.statusCode == 200) {
        setState(() {
          unemployedLists.removeWhere(
              (unemployed) => unemployed['student_no'] == studentNo);
        });
      } else {
        print('Failed to delete unemployed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting unemployed: $e');
    }
  }

  Future<void> updateUnemployed(String studentNo) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/unemployed_update.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'student_no': controllers['student_no']!.text,
          'last_name': controllers['last_name']!.text,
          'first_name': controllers['first_name']!.text,
          'middle_name': controllers['middle_name']!.text,
          'birthdate': controllers['birthdate']!.text,
          'age': int.tryParse(controllers['age']!.text) ?? 0,
          'home_address': controllers['home_address']!.text,
          'personal_email': controllers['personal_email']!.text,
          'facebook_name': controllers['facebook_name']!.text,
          'course': controllers['course']!.text,
          'graduation_date': controllers['graduation_date']!.text,
          'your_job_before': controllers['your_job_before']!.text,
          'reason_of_unemployment': controllers['reason_of_unemployment']!.text,
          'board_passer?': controllers['board_passer?']!.text,
          'target_next_jobtitle': controllers['target_next_jobtitle']!.text,
          'target_salary': controllers['target_salary']!.text,
        }),
      );
      if (response.statusCode == 200) {
        fetchUnemployedLists();
      } else {
        print('Failed to update unemployed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating unemployed: $e');
    }
  }

  Future<void> createUnemployed() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/unemployed_create.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'student_no': controllers['student_no']?.text,
          'last_name': controllers['last_name']?.text,
          'first_name': controllers['first_name']?.text,
          'middle_name': controllers['middle_name']?.text,
          'birthdate': controllers['birthdate']?.text,
          'age': int.tryParse(controllers['age']?.text ?? '0') ?? 0,
          'home_address': controllers['home_address']?.text,
          'personal_email': controllers['personal_email']?.text,
          'facebook_name': controllers['facebook_name']?.text,
          'course': controllers['course']?.text,
          'graduation_date': controllers['graduation_date']?.text,
          'your_job_before': controllers['your_job_before']?.text,
          'reason_of_unemployment': controllers['reason_of_unemployment']?.text,
          'board_passer?': controllers['board_passer?']?.text,
          'target_next_jobtitle': controllers['target_next_jobtitle']?.text,
          'target_salary': controllers['target_salary']?.text,
        }),
      );
      if (response.statusCode == 200) {
        fetchUnemployedLists();
      } else {
        print('Failed to create unemployed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating unemployed: $e');
    }
  }

  void showUpdateDialog(Map<String, dynamic> unemployed) {
    controllers.clear();
    unemployed.forEach((key, value) {
      controllers[key] = TextEditingController(text: value?.toString() ?? '');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Unemployed Record'),
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
                updateUnemployed(unemployed['student_no']);
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
          title: const Text('Create Unemployed Record'),
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
                  'personal_email',
                  'facebook_name',
                  'course',
                  'graduation_date',
                  'your_job_before',
                  'reason_of_unemployment',
                  'board_passer?',
                  'target_next_jobtitle',
                  'target_salary'
                ])
                  TextField(
                    controller: controllers[key] = TextEditingController(),
                    decoration:
                        InputDecoration(labelText: key.replaceAll('_', ' ').toUpperCase()),
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
                createUnemployed();
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
      body: unemployedLists.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Student No')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Course')),
                  DataColumn(label: Text('Graduation Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: unemployedLists.map((unemployed) {
                  return DataRow(cells: [
                    DataCell(Text(unemployed['student_no'] ?? 'N/A')),
                    DataCell(Text(
                        '${unemployed['first_name']} ${unemployed['last_name']}')),
                    DataCell(Text(unemployed['course'] ?? 'N/A')),
                    DataCell(Text(unemployed['graduation_date'] ?? 'N/A')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showUpdateDialog(unemployed),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              deleteUnemployed(unemployed['student_no'] ?? ''),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
