import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/graduates_tracer_industry/GraduatesLists.dart';
import 'package:flutter_app/services/graduates_lists_api_service.dart';

class GraduatesListsDepartmentDirector extends StatefulWidget {
  final String departmentName;

  const GraduatesListsDepartmentDirector(
      {super.key, required this.departmentName});

  @override
  _GraduatesListsDepartmentDirectorState createState() =>
      _GraduatesListsDepartmentDirectorState();
}

class _GraduatesListsDepartmentDirectorState
    extends State<GraduatesListsDepartmentDirector> {
  late Future<List<GraduatesList>> futureGraduatesLists;
  final GraduatesListApiService apiService = GraduatesListApiService();
  final controllers = <String, TextEditingController>{};
  DateTime birthdate = DateTime.now();
  DateTime graduationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureGraduatesLists = apiService.fetchGraduatesList();
  }

  Future<void> createGraduate() async {
    // Validate if any field is empty
    if (controllers.values.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    // Parse and validate birthdate
    DateTime? parsedBirthdate;
    try {
      parsedBirthdate = DateTime.parse(controllers['birthdate']?.text ?? '');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid birthdate format. Use YYYY-MM-DD')),
      );
      return;
    }

    // Parse and validate graduation date
    DateTime? parsedGraduationDate;
    try {
      parsedGraduationDate =
          DateTime.parse(controllers['graduation_date']?.text ?? '');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid graduation date format. Use YYYY-MM-DD')),
      );
      return;
    }

    // Create the graduate object with properly extracted text
    final graduatesListData = GraduatesList(
      studentNo: controllers['student_no']?.text ?? '',
      lastName: controllers['last_name']?.text ?? '',
      firstName: controllers['first_name']?.text ?? '',
      middleName: controllers['middle_name']?.text ?? '',
      birthdate: parsedBirthdate, // Format: YYYY-MM-DD
      age: int.tryParse(controllers['age']?.text ?? '0') ?? 0,
      homeAddress: controllers['home_address']?.text ?? '',
      uncEmail: controllers['unc_email']?.text ?? '',
      personalEmail: controllers['personal_email']?.text ?? '',
      facebookName: controllers['facebook_name']?.text ?? '',
      graduationDate: parsedGraduationDate, // Format: YYYY-MM-DD
      course: controllers['course']?.text ?? '',
      firstTargetEmployer: controllers['1st_target_employer']?.text ?? '',
      secondTargetEmployer: controllers['2nd_target_employer']?.text ?? '',
      thirdTargetEmployer: controllers['3rd_target_employer']?.text ?? '',
    );

    if (kDebugMode) {
      debugPrint('Sending data to API: ${graduatesListData.toJson()}');
    }

    try {
      await apiService.createGraduate(graduatesListData);

      // Refresh the UI after a successful creation
      setState(() {
        futureGraduatesLists = apiService.fetchGraduatesList();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Graduate added successfully')),
      );
      Navigator.pop(context, true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add graduate: $error')),
      );
    }
  }

  void showCreateDialog() {
    controllers.clear();
    birthdate = DateTime.now();
    graduationDate = DateTime.now();

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
                ])
                  TextField(
                    controller: controllers[key] = TextEditingController(),
                    decoration: InputDecoration(
                        labelText: key.replaceAll('_', ' ').toUpperCase()),
                  ),
                const SizedBox(height: 16),
                // Date Picker for Birthdate
                Text('BIRTHDATE:',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        birthdate = selectedDate;
                      });
                    }
                  },
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(birthdate),
                  ),
                ),
                for (String key in [
                  'age',
                  'home_address',
                  'unc_email',
                  'personal_email',
                  'facebook_name',
                ])
                  TextField(
                    controller: controllers[key] = TextEditingController(),
                    decoration: InputDecoration(
                        labelText: key.replaceAll('_', ' ').toUpperCase()),
                  ),
                const SizedBox(height: 16),
                // Date Picker for Graduation Date
                Text('GRADUATION DATE:',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        graduationDate = selectedDate;
                      });
                    }
                  },
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(graduationDate),
                  ),
                ),
                for (String key in [
                  'course',
                  '1st_target_employer',
                  '2nd_target_employer',
                  '3rd_target_employer',
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
                controllers['birthdate'] = TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(birthdate),
                );
                controllers['graduation_date'] = TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(graduationDate),
                );
                createGraduate();
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
                DataColumn(label: Text('Graduation Date')),
                DataColumn(label: Text('Course')),
                DataColumn(label: Text('1st Target Employer')),
                DataColumn(label: Text('2nd Target Employer')),
                DataColumn(label: Text('3rd Target Employer')),
                DataColumn(label: Text('Actions')),
              ],
              rows: graduates.map((graduate) {
                return DataRow(cells: [
                  DataCell(Text(graduate.studentNo?.toString() ?? 'N/A')),
                  DataCell(Text(graduate.lastName)),
                  DataCell(Text(graduate.firstName)),
                  DataCell(Text(graduate.middleName)),
                  DataCell(Text(DateFormat('yyyy-MM-dd').format(graduate.birthdate))),
                  DataCell(Text(graduate.age.toString())),
                  DataCell(Text(graduate.homeAddress)),
                  DataCell(Text(graduate.uncEmail)),
                  DataCell(Text(graduate.personalEmail)),
                  DataCell(Text(graduate.facebookName)),
                  DataCell(Text(DateFormat('yyyy-MM-dd').format(graduate.graduationDate))),
                  DataCell(Text(graduate.course)),
                  DataCell(Text(graduate.firstTargetEmployer)),
                  DataCell(Text(graduate.secondTargetEmployer)),
                  DataCell(Text(graduate.thirdTargetEmployer)),
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
