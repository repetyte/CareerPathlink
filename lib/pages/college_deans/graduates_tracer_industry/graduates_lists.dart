import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GraduatesLists extends StatefulWidget {
  final String departmentName;

  const GraduatesLists({super.key, required this.departmentName});

  @override
  _GraduatesListsState createState() => _GraduatesListsState();
}

class _GraduatesListsState extends State<GraduatesLists> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> graduates = [];
  List<Map<String, dynamic>> filteredGraduates = [];

  @override
  void initState() {
    super.initState();
    fetchGraduates();
  }

  Future<void> fetchGraduates() async {
    final response = await http.get(Uri.parse(
        'http://yourserver.com/fetch_graduates.php?department=${widget.departmentName}'));
    if (response.statusCode == 200) {
      final List fetchedData = json.decode(response.body);
      setState(() {
        graduates = fetchedData.map((graduate) {
          return {
            'grad_id': graduate['grad_id'],
            'name': graduate['full_name'],
            'age': graduate['age'],
            'address': graduate['address'],
            'cp_no': graduate['cp_no'],
            'course': graduate['course'],
            'date_grad': graduate['date_grad'],
            'emp_stat': graduate['emp_stat'],
          };
        }).toList();
        filteredGraduates = graduates;
      });
    } else {
      throw Exception('Failed to load graduates');
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> dummySearchList = [];
    dummySearchList.addAll(graduates);
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> dummyListData = [];
      for (var item in dummySearchList) {
        if (item['name']!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredGraduates = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredGraduates = graduates;
      });
    }
  }

  void deleteGraduate(int id) async {
    final response = await http.post(
      Uri.parse('http://yourserver.com/delete_graduate.php'),
      body: {'id': id.toString()},
    );
    if (response.statusCode == 200) {
      setState(() {
        graduates.removeWhere((graduate) => graduate['grad_id'] == id);
        filteredGraduates = graduates;
      });
    } else {
      throw Exception('Failed to delete graduate');
    }
  }

  void showCreateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController cpNoController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController dateGradController = TextEditingController();
    TextEditingController empStatController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Graduate Record'),
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
                  controller: empStatController,
                  decoration:
                      const InputDecoration(labelText: 'Employability Status'),
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
                  Uri.parse('http://yourserver.com/create_graduate.php'),
                  body: {
                    'full_name': nameController.text,
                    'age': ageController.text,
                    'address': addressController.text,
                    'cp_no': cpNoController.text,
                    'course': courseController.text,
                    'date_grad': dateGradController.text,
                    'emp_stat': empStatController.text,
                  },
                );
                if (response.statusCode == 200) {
                  fetchGraduates(); // Fetch the updated list of graduates after creating a new one
                  Navigator.pop(context);
                } else {
                  throw Exception('Failed to create graduate');
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
                            width: 15),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/vectors/battery_1_x2.svg',
                            width: 24),
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
                          'Graduates Lists',
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
                      padding: const EdgeInsets.symmetric(horizontal: 12.6, vertical: 5),
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
                    DataColumn(label: Text('Employability Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredGraduates.map((graduate) {
                    return DataRow(cells: [
                      DataCell(Text(graduate['grad_id'].toString())),
                      DataCell(Text(graduate['name'])),
                      DataCell(Text(graduate['age'].toString())),
                      DataCell(Text(graduate['address'])),
                      DataCell(Text(graduate['cp_no'])),
                      DataCell(Text(graduate['course'])),
                      DataCell(Text(graduate['date_grad'])),
                      DataCell(Text(graduate['emp_stat'])),
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
                                deleteGraduate(graduate['grad_id']);
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
