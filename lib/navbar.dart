import 'package:flutter/material.dart';
import 'package:ssm_app/projects/project_list_page.dart';
import 'package:ssm_app/task/task_list_page.dart';

import 'Activity/activity_list_page.dart';
import 'Screens/dashboard_screen.dart';
import 'about us/aboutUs_page.dart';
import 'client/client_list.page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      child: ListView(
        padding: const EdgeInsets.only(top: 25),
        children: [
          GestureDetector(
            child: ListTile(
                title: const Text(
                  "Dashboard",
                  style: TextStyle(height: 0, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.person_2,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()))),
          ),
          GestureDetector(
            child: ListTile(
                title: const Text(
                  "Client",
                  style: TextStyle(height: 0, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.person_2,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ClientListPage()))),
          ),
          GestureDetector(
            child: ListTile(
              title: const Text(
                "Project",
                style: TextStyle(height: 0, color: Colors.white),
              ),
              leading: const Icon(
                Icons.file_copy,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectListPage()));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: const Text(
                "Task",
                style: TextStyle(height: 0, color: Colors.white),
              ),
              leading: const Icon(
                Icons.task_rounded,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TaskListPage()));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: const Text(
                "Activity",
                style: TextStyle(height: 0, color: Colors.white),
              ),
              leading: const Icon(
                Icons.local_activity,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ActivityListPage()));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: const Text(
                "About Us",
                style: TextStyle(height: 0, color: Colors.white),
              ),
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              },
            ),
          ),
          // GestureDetector(
          //   child: ListTile(
          //     title: const Text(
          //       "Change Theme",
          //       style: TextStyle(height: 0, color: Colors.white),
          //     ),
          //     leading: const Icon(
          //       Icons.color_lens,
          //       color: Colors.white,
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const ChangeTheme()));
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
