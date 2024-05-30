import 'package:flutter/material.dart';
import 'package:flutter_app/pages/hendrixon_dashboard_user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // title: Row(
          //   // mainAxisAlignment: MainAxisAlignment.start,
          //   // crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          //       decoration: const BoxDecoration(
          //         image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage(
          //             'assets/images/seal_of_university_of_nueva_caceres_2.png',
          //           ),
          //         ),
          //       ),
          //       child: const SizedBox(
          //         width: 48,
          //         height: 48,
          //       ),
          //     ),
          //     Column(children: [
          //       Text('CAREER CENTER',
          //           style: GoogleFonts.getFont(
          //             'Montserrat',
          //             fontWeight: FontWeight.w700,
          //             fontSize: 16,
          //             color: const Color(0xFF000000),
          //           )),
          //       Text('Management System',
          //           style: GoogleFonts.getFont(
          //             'Montserrat',
          //             fontWeight: FontWeight.w700,
          //             fontSize: 14,
          //             color: const Color(0xFF000000),
          //           )),
          //     ]),
          //   ],
          // ),
          // toolbarHeight: 80,
          centerTitle: false,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Text('UNIVERSITY',
                          style: TextStyle(
                            // fontWeight: FontWeight.w700,
                            fontSize: 12,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                      Text('CAREER CENTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                      Text('Management System',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                    ]),
                  ],
                ),
                // child: Text('University\nCAREER CENTER\nManagement System'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: const Icon(Icons.work),
                title: const Text(
                  'Recruitment and Placement',
                  style: TextStyle(
                      // fontSize: 16,
                      // // fontWeight: FontWeight.w700,
                      // // color: Color(0xFFFF0000)
                      ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.on_device_training),
                title: const Text(
                  'Career Engagement and Training',
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: const HendrixonDashboardUser(),
      ),
    );
  }
}