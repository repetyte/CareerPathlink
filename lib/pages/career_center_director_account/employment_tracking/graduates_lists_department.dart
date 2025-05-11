import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/graduates_tracer_industry/graduates_lists.dart';
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
  final TextEditingController searchController = TextEditingController();
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    futureGraduatesLists = apiService.fetchGraduatesList();
  }

  Future<void> createGraduate() async {
    try {
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
          'graduation_date': controllers['graduation_date']?.text,
          'course': controllers['course']?.text,
          'first_target_employer': controllers['first_target_employer']?.text,
          'second_target_employer': controllers['second_target_employer']?.text,
          'third_target_employer': controllers['third_target_employer']?.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Graduate created successfully!')),
        );
        setState(() {
          futureGraduatesLists = apiService.fetchGraduatesList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create graduate')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
                  'student_no', 'last_name', 'first_name', 'middle_name',
                  'home_address', 'unc_email', 'personal_email', 'facebook_name',
                  'course', 'first_target_employer', 'second_target_employer',
                  'third_target_employer'
                ])
                  TextField(
                    controller: controllers[key] = TextEditingController(),
                    decoration: InputDecoration(
                      labelText: key
                          .replaceAll('_', ' ') // Convert underscores to spaces
                          .split(' ') // Split words
                          .map((word) => word[0].toUpperCase() + word.substring(1)) // Capitalize first letter
                          .join(' '), // Join words back together
                    ),
                  ),

                // Date picker for Birthdate
                TextField(
                  controller: controllers['birthdate'] = TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Birthdate'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    controllers['birthdate']!.text =
                        "${pickedDate?.toLocal()}".split(' ')[0];
                                    },
                ),

                // Age input (numeric only)
                TextField(
                  controller: controllers['age'] = TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),

                // Date picker for Graduation Date
                TextField(
                  controller: controllers['graduation_date'] = TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Graduation Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2050),
                    );
                    controllers['graduation_date']!.text =
                        "${pickedDate?.toLocal()}".split(' ')[0];
                                    },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
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
      appBar: AppBar(title: Text(widget.departmentName)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by Name, Course, or Graduation Date',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: showCreateDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Create'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GraduatesList>>(
              future: futureGraduatesLists,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No graduates found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final graduate = snapshot.data![index];
                    return ListTile(
                      title: Text('${graduate.firstName} ${graduate.lastName}'),
                      subtitle: Text('${graduate.course} | ${graduate.graduationDate}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
