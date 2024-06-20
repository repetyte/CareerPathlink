import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployedLists extends StatefulWidget {
  final String departmentName;

  const EmployedLists({super.key, required this.departmentName});

  @override
  _EmployedListsState createState() => _EmployedListsState();
}

class _EmployedListsState extends State<EmployedLists> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final response = await http.get(Uri.parse(
        'http://yourserver.com/fetch_employees.php?department=${widget.departmentName}'));
    if (response.statusCode == 200) {
      final List fetchedData = json.decode(response.body);
      setState(() {
        employees = fetchedData.map((employee) {
          return {
            'emp_id': employee['emp_id'],
            'name': employee['full_name'],
            'age': employee['age'],
            'address': employee['address'],
            'cp_no': employee['cp_no'],
            'course': employee['course'],
            'date_grad': employee['date_grad'],
            'job_name': employee['job_name'],
            'job_industry': employee['job_industry'],
            'salary': employee['salary'],
            'date_hired': employee['date_hired'],
          };
        }).toList();
        filteredEmployees = employees;
      });
    } else {
      throw Exception('Failed to load employees');
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> dummySearchList = [];
    dummySearchList.addAll(employees);
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> dummyListData = [];
      for (var item in dummySearchList) {
        if (item['name']!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredEmployees = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredEmployees = employees;
      });
    }
  }

  void deleteEmployee(int id) async {
    final response = await http.post(
      Uri.parse('http://yourserver.com/delete_employee.php'),
      body: {'id': id.toString()},
    );
    if (response.statusCode == 200) {
      setState(() {
        employees.removeWhere((employee) => employee['emp_id'] == id);
        filteredEmployees = employees;
      });
    } else {
      throw Exception('Failed to delete employee');
    }
  }

  void showCreateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController cpNoController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController dateGradController = TextEditingController();
    TextEditingController jobNameController = TextEditingController();
    TextEditingController jobIndustryController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    TextEditingController dateHiredController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Employee Record'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: cpNoController,
                  decoration: const InputDecoration(labelText: 'Contact Number'),
                ),
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: 'Course'),
                ),
                TextField(
                  controller: dateGradController,
                  decoration: const InputDecoration(labelText: 'Date of Graduation'),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: jobNameController,
                  decoration: const InputDecoration(labelText: 'Job Name'),
                ),
                TextField(
                  controller: jobIndustryController,
                  decoration: const InputDecoration(labelText: 'Job Industry'),
                ),
                TextField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: dateHiredController,
                  decoration: const InputDecoration(labelText: 'Date Hired'),
                  keyboardType: TextInputType.datetime,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('http://yourserver.com/create_employee.php'),
                  body: {
                    'full_name': nameController.text,
                    'age': ageController.text,
                    'address': addressController.text,
                    'cp_no': cpNoController.text,
                    'course': courseController.text,
                    'date_grad': dateGradController.text,
                    'job_name': jobNameController.text,
                    'job_industry': jobIndustryController.text,
                    'salary': salaryController.text,
                    'date_hired': dateHiredController.text,
                  },
                );
                if (response.statusCode == 200) {
                  Navigator.pop(context);
                  fetchEmployees(); // Fetch the updated list of employees after creating a new one
                } else {
                  throw Exception('Failed to create employee');
                }
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
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 77,
              decoration: const BoxDecoration(
                color: Color(0xFF232222),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/mobile_signal_1_x2.svg',
                            width: 17,
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/vectors/wifi_x2.svg',
                            width: 15,
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/vectors/battery_1_x2.svg',
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 10, 11, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/back.png'),
                          iconSize: 38,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          'Employed Lists',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 27,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                          radius: 30,
                        ),
                      ],
                    ),
                    Text(
                      'Last Update: 10 Aug. 2023',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12.6, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFFFFFFFF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(3, 4),
                            blurRadius: 3,
                          ),
                        ],
                        border: Border.all(color: const Color(0xFF000000)),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: filterSearchResults,
                        decoration: InputDecoration(
                          hintText: 'Search the name...',
                          hintStyle: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xFF676565),
                          ),
                          border: InputBorder.none,
                          suffixIcon: Image.asset('assets/images/search.png',
                              width: 28, height: 28),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.departmentName,
              style: GoogleFonts.getFont(
                'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: const Color(0xFF000000),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: showCreateDialog,
                child: const Text('Create'),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Contact Number')),
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Date of Graduation')),
                    DataColumn(label: Text('Job Name')),
                    DataColumn(label: Text('Job Industry')),
                    DataColumn(label: Text('Salary')),
                    DataColumn(label: Text('Date Hired')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredEmployees.map((employee) {
                    return DataRow(cells: [
                      DataCell(Text(employee['emp_id'].toString())),
                      DataCell(Text(employee['name'])),
                      DataCell(Text(employee['age'].toString())),
                      DataCell(Text(employee['address'])),
                      DataCell(Text(employee['cp_no'])),
                      DataCell(Text(employee['course'])),
                      DataCell(Text(employee['date_grad'])),
                      DataCell(Text(employee['job_name'])),
                      DataCell(Text(employee['job_industry'])),
                      DataCell(Text(employee['salary'].toString())),
                      DataCell(Text(employee['date_hired'])),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Implement edit functionality here
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteEmployee(employee['emp_id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
