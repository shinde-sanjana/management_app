import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // final _formfield = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  Future fetchProfileDetails() async {
    // print(AppConfig.profile);
    try {
      final response = await http.get(Uri.parse(AppConfig.profile),
          headers: AppConfig.requestHeaders);
      final data = json.decode(response.body);
      // print(data);
      if (response.statusCode == 200) {
        nameController.text = data['user']['name'];
        emailController.text = data['user']['email'];
        mobileController.text = data['user']['mobile'].toString();
        return data;
      } else {
        var errorMessage = data['message'];
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        return "false";
      }
    } catch ($e) {
      // return throw Exception('Failed to load profile details');

      const errorMessage = 'Failed to load profile details';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future saveProfile() async {
    // print(AppConfig.updateprofile);
    // try {
    var jsonBody = {
      'name': nameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
    };
    final response = await http.put(Uri.parse(AppConfig.updateprofile),
        headers: AppConfig.requestHeaders, body: jsonEncode(jsonBody));
    final data = json.decode(response.body);
    // print(data);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Updated Successfully")),
      );
      return data;
    } else {
      var errorMessage = data['message'];
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return "false";
    }
    // } catch ($e) {
    //   // return throw Exception('Failed to load profile details');

    //   const errorMessage = 'Failed to load profile details';
    //   // ignore: use_build_context_synchronously
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text(errorMessage)),
    //   );
    // }
  }

  @override
  void initState() {
    if (!AppConfig.offline) {
      fetchProfileDetails();
    } else {
      // print("Work on offline method.");
    }
    super.initState();
    // check_if_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9g1ihD3e3aKZ-E78bD7gILiEMXM2CaEUKeg&usqp=CAU",
                  height: 90,
                  width: 90,
                  //color: Color.fromARGB(255, 97, 8, 119),
                )),
            const SizedBox(height: 15),
            SizedBox(
              width: 450,
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    hintText: 'Enter Full name',
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter full name";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 450,
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    icon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    hintText: 'Enter Email Address',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email address";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 450,
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                keyboardType: TextInputType.phone,
                controller: mobileController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    icon: Icon(
                      Icons.contact_page,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    hintText: 'Enter Contact Number',
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter contact number";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  saveProfile();
                  // Navigator.pop(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ProfileScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                ),
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                ),
                child: const Text('Cancel'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
