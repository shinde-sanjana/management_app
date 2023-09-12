import 'package:flutter/material.dart';

import 'Menu/Setting/setting_screen.dart';
import 'Menu/logout_screen.dart';
import 'Menu/profile/profile_screen.dart';
import 'notification_page.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
            icon: const Icon(Icons.notifications)),
        GestureDetector(
          child: PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingScreen()));
                    },
                    title: const Text(
                      "Settings",
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 8, 119),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 8, 119),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogoutPage()));
                    },
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Color.fromARGB(255, 97, 8, 119),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
