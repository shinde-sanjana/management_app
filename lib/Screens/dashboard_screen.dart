import 'package:flutter/material.dart';
import 'package:ssm_app/custom_appbar.dart';
import 'package:ssm_app/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final String _selectedColor = "Blue";
  // final List<String> _color = ["Dark", "Light", "purple", "Blue"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        toolbarHeight: 40,
        actions: const <Widget>[CustomAppBar()],
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const NotificationPage()));
        //       },
        //       icon: const Icon(Icons.notifications)),
        //   GestureDetector(
        //     child: PopupMenuButton(
        //       itemBuilder: (context) {
        //         return [
        //           PopupMenuItem<int>(
        //             value: 0,
        //             child: ListTile(
        //               leading: const Icon(
        //                 Icons.settings,
        //                 color: Color.fromARGB(255, 97, 8, 119),
        //               ),
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => const SettingScreen()));
        //               },
        //               title: const Text(
        //                 "Settings",
        //                 style: TextStyle(
        //                     color: Color.fromARGB(255, 97, 8, 119),
        //                     fontWeight: FontWeight.w500),
        //               ),
        //             ),
        //           ),
        //           PopupMenuItem<int>(
        //             value: 0,
        //             child: ListTile(
        //               leading: const Icon(
        //                 Icons.person,
        //                 color: Color.fromARGB(255, 97, 8, 119),
        //               ),
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => const ProfileScreen()));
        //               },
        //               title: const Text(
        //                 "Profile",
        //                 style: TextStyle(
        //                     color: Color.fromARGB(255, 97, 8, 119),
        //                     fontWeight: FontWeight.w500),
        //               ),
        //             ),
        //           ),
        //           PopupMenuItem<int>(
        //             value: 0,
        //             child: ListTile(
        //               leading: const Icon(
        //                 Icons.logout,
        //                 color: Color.fromARGB(255, 97, 8, 119),
        //               ),
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => const LogoutPage()));
        //               },
        //               title: const Text(
        //                 "Logout",
        //                 style: TextStyle(
        //                   color: Color.fromARGB(255, 97, 8, 119),
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ];
        //       },
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
