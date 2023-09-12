import 'package:flutter/material.dart';

import 'edit_profile_page.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final _formfield = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  // Future profile() async {
  //   final response = await http.put((profile) as Uri);
  //   if (response.statusCode == 200) {
  //     AppConfig.profile = jsonDecode(response.body);
  //   }
  // }

  // Future<Map<String, dynamic>> fetchProfileDetails() async {
  //   final url = '';

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to fetch profile details');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("profile"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        ),
        body: Align(
          child: ListView(children: [
            const SizedBox(
              height: 70,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
                title: Text(
                  "Account",
                  style: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Edit profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            // ignore: prefer_const_constructors
                            builder: (context) => ChangePasswordPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
