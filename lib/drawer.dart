import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  navigateTo(String route, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Row(
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
                        Text('MANAGEMENT SYSTEM',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              // color: const Color(0xFF000000),
                              height: 1.3,
                            )),
                      ]),
                    ],
                  ),
                ]
            ),
            // child: Text('University\nCAREER CENTER\nManagement System'),
          ),
          const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              // onTap: (){
              //   Navigator.push(context,
              //       new MaterialPageRoute(builder: (context) => new JobPostingScreen()));
              // }
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text(
              'Recruitment and Placement',
              style: TextStyle(
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
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
    );
  }
}