import 'dart:convert';

import 'package:flutter/material.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  // final _formfield = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final aliasController = TextEditingController();
  // final jiraprojectController = TextEditingController();

  Future fetchClientDetails() async {
    // print(AppConfig.clients);`

    try {
      final response = await http.get(Uri.parse("${AppConfig.clients}/1"),
          headers: AppConfig.requestHeaders);
      final data = json.decode(response.body);
      // print(data);
      if (response.statusCode == 200) {
        nameController.text = data['message']['record']['name'].toString();
        aliasController.text = data['message']['record']['alias'].toString();
        phoneController.text = data['message']['record']['phone'].toString();
        emailController.text = data['message']['record']['email'].toString();
        return data;
      } else {
        var errorMessage = data['errors'];
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        return "false";
      }
    } catch (e) {
      // return throw Exception('Failed to load profile details');

      var errorMessage = 'Failed to load client details \r\n $e';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future saveClient() async {
    // print(AppConfig.clients);
    // try {
    var jsonBody = {
      'name': nameController.text,
      'mobile': phoneController.text,
      'email': emailController.text,
      'alias': aliasController.text,
      // 'jiraproject': jiraprojectController.text,
    };
    final response = await http.put(Uri.parse("${AppConfig.clients}/1"),
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
  }

  @override
  void initState() {
    if (!AppConfig.offline) {
      fetchClientDetails();
    } else {
      // print("Work on offline method.");
    }
    super.initState();
    // check_if_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 97, 8, 119),
          title: const Text('Clients List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                // style: TextStyle(
                //   color: const Color.fromARGB(255, 97, 8, 119),
                // ),
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
                    hintText: 'Client Name',
                    labelText: 'Client Name',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 97, 8, 119),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ))),
              ),
              const SizedBox(height: 10),
              TextField(
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                keyboardType: TextInputType.name,
                controller: aliasController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    hintText: 'alias',
                    labelText: 'alias',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 97, 8, 119),
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              TextField(
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                keyboardType: TextInputType.phone,

                controller: phoneController,
                // keyboardType: TextInputType.number,
                // maxLength: 10,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    hintText: 'Contact Number',
                    labelText: 'phone',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 97, 8, 119),
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              TextField(
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
                    hintText: 'Email Id',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
              ),
              const SizedBox(height: 10),
              // TextField(
              //   cursorColor: const Color.fromARGB(255, 97, 8, 119),
              //   keyboardType: TextInputType.text,
              //   controller: jiraprojectController,
              //   decoration: const InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //         color: Color.fromARGB(255, 97, 8, 119),
              //       )),
              //       focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //         color: Color.fromARGB(255, 97, 8, 119),
              //       )),
              //       hintText: 'Projects',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ))),
              // ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        saveClient();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text(
                        'Save',
                      )),
                  ElevatedButton(
                      onPressed: () {
                        // String name = nameController.text.trim();
                        // String contact = contactController.text.trim();
                        // String email = emailController.text.trim();
                        // String projects = projectsController.text.trim();

                        // if (name.isNotEmpty &&
                        //     contact.isNotEmpty &&
                        //     email.isNotEmpty &&
                        //     projects.isNotEmpty) {
                        //   setState(() {
                        //     nameController.text = '';
                        //     contactController.text = '';
                        //     contacts[selectedIndex].name = name;
                        //     contacts[selectedIndex].contact = contact;
                        //     selectedIndex = -1;
                        //   });
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text('Cancel')),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(onTap: () {}, child: const Icon(Icons.edit)),
              InkWell(onTap: (() {}), child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
