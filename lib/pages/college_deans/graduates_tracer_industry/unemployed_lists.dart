import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UnemployedLists extends StatefulWidget {
  final String departmentName;

  const UnemployedLists({super.key, required this.departmentName});

  @override
  _UnemployedListsState createState() => _UnemployedListsState();
}

class _UnemployedListsState extends State<UnemployedLists> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> unemployed = [];
  List<Map<String, dynamic>> filteredUnemployed = [];

  @override
  void initState() {
    super.initState();
    fetchUnemployed();
  }

  Future<void> fetchUnemployed() async {
    final response = await http.get(Uri.parse(
        'http://yourserver.com/fetch_unemployed.php?department=${widget.departmentName}'));
    if (response.statusCode == 200) {
      final List fetchedData = json.decode(response.body);
      setState(() {
        unemployed = fetchedData.map((unemployed) {
          return {
            'id': unemployed['id'],
            'previous_job': unemployed['previous_job'],
            'name': unemployed['full_name'],
            'age': unemployed['age'],
            'address': unemployed['address'],
            'course': unemployed['course'],
            'date_grad': unemployed['date_grad'],
            'reason_unemp': unemployed['reason_unemp'],
            'next_target_job': unemployed['next_target_job'],
          };
        }).toList();
        filteredUnemployed = unemployed;
      });
    } else {
      throw Exception('Failed to load unemployed');
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> dummySearchList = [];
    dummySearchList.addAll(unemployed);
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> dummyListData = [];
      for (var item in dummySearchList) {
        if (item['name']!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredUnemployed = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredUnemployed = unemployed;
      });
    }
  }

  void deleteUnemployed(int id) async {
    final response = await http.post(
      Uri.parse('http://yourserver.com/delete_unemployed.php'),
      body: {'id': id.toString()},
    );
    if (response.statusCode == 200) {
      setState(() {
        unemployed.removeWhere((unemployed) => unemployed['id'] == id);
        filteredUnemployed = unemployed;
      });
    } else {
      throw Exception('Failed to delete unemployed');
    }
  }

  void showCreateDialog() {
    TextEditingController previousJobController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController dateGradController = TextEditingController();
    TextEditingController reasonUnempController = TextEditingController();
    TextEditingController nextTargetJobController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Unemployed Record'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: previousJobController,
                  decoration: const InputDecoration(labelText: 'Previous Job'),
                ),
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
                  controller: courseController,
                  decoration: const InputDecoration(labelText: 'Course'),
                ),
                TextField(
                  controller: dateGradController,
                  decoration:
                      const InputDecoration(labelText: 'Date of Graduation'),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: reasonUnempController,
                  decoration: const InputDecoration(
                      labelText: 'Reason for Unemployment'),
                ),
                TextField(
                  controller: nextTargetJobController,
                  decoration:
                      const InputDecoration(labelText: 'Next Target Job'),
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
                  Uri.parse('http://yourserver.com/create_unemployed.php'),
                  body: {
                    'previous_job': previousJobController.text,
                    'full_name': nameController.text,
                    'age': ageController.text,
                    'address': addressController.text,
                    'course': courseController.text,
                    'date_grad': dateGradController.text,
                    'reason_unemp': reasonUnempController.text,
                    'next_target_job': nextTargetJobController.text,
                  },
                );
                if (response.statusCode == 200) {
                  fetchUnemployed(); // Refresh the list
                  Navigator.pop(context); // Close the dialog
                } else {
                  throw Exception('Failed to create unemployed');
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
                          'Unemployed Lists',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.6, vertical: 5),
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
                    DataColumn(label: Text('Previous Job')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Date of Graduation')),
                    DataColumn(label: Text('Reason for Unemployment')),
                    DataColumn(label: Text('Next Target Job')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredUnemployed.map((unemployed) {
                    return DataRow(cells: [
                      DataCell(Text(unemployed['id'].toString())),
                      DataCell(Text(unemployed['previous_job'])),
                      DataCell(Text(unemployed['name'])),
                      DataCell(Text(unemployed['age'].toString())),
                      DataCell(Text(unemployed['address'])),
                      DataCell(Text(unemployed['course'])),
                      DataCell(Text(unemployed['date_grad'])),
                      DataCell(Text(unemployed['reason_unemp'])),
                      DataCell(Text(unemployed['next_target_job'])),
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
                                deleteUnemployed(unemployed['id']);
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
