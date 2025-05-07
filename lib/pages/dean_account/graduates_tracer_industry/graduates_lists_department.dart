import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/graduates_tracer_industry/graduates_lists.dart';
import 'package:flutter_app/services/graduates_lists_api_service.dart';

class GraduatesListsDepartmentDean extends StatefulWidget {
  final String departmentName;

  const GraduatesListsDepartmentDean({super.key, required this.departmentName});

  @override
  _GraduatesListsDepartmentDeanState createState() =>
      _GraduatesListsDepartmentDeanState();
}

class _GraduatesListsDepartmentDeanState extends State<GraduatesListsDepartmentDean> {
  late Future<List<GraduatesList>> futureGraduatesLists;
  List<GraduatesList> allGraduates = [];
  List<GraduatesList> filteredGraduates = [];
  final GraduatesListApiService apiService = GraduatesListApiService();
  final controllers = <String, TextEditingController>{};
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchGraduates();
    searchController.addListener(_filterSearchResults);
  }

  Future<void> fetchGraduates() async {
    try {
      final graduates = await apiService.fetchGraduatesList();
      setState(() {
        allGraduates = graduates.where((grad) => grad.department == widget.departmentName).toList();
        filteredGraduates = allGraduates;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching graduates: $e');
      }
    }
  }

  void _filterSearchResults() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredGraduates = allGraduates.where((grad) {
        return grad.lastName.toLowerCase().contains(query) ||
               grad.firstName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.departmentName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by First or Last Name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
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
                  DataColumn(label: Text('Graduation Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: filteredGraduates.map((graduate) {
                  return DataRow(cells: [
                    DataCell(Text(graduate.studentNo ?? 'N/A')),
                    DataCell(Text(graduate.lastName)),
                    DataCell(Text(graduate.firstName)),
                    DataCell(Text(graduate.middleName)),
                    DataCell(Text(graduate.birthdate)),
                    DataCell(Text(graduate.age.toString())),
                    DataCell(Text(graduate.homeAddress)),
                    DataCell(Text(graduate.uncEmail)),
                    DataCell(Text(graduate.personalEmail)),
                    DataCell(Text(graduate.facebookName)),
                    DataCell(Text(graduate.course)),
                    DataCell(Text(graduate.graduationDate)),
                    // DataCell(Row(
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(Icons.edit),
                    //       onPressed: () {
                    //         // Implement update logic here
                    //       },
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.delete),
                    //       onPressed: () {
                    //         // Implement delete logic here
                    //       },
                    //     ),
                    //   ],
                    // )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {}, // Implement create logic here
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
