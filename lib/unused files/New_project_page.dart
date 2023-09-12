// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class NewProject extends StatelessWidget {
  const NewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Project"),
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      ),
      body: const ProjectForm(),
    );
  }
}

class ProjectForm extends StatefulWidget {
  const ProjectForm({super.key});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final clientnameController = TextEditingController();
  final projectnameController = TextEditingController();
  final projectdescriptionController = TextEditingController();
  final stagesController = TextEditingController();

  Future fetchClientDetails() async {
    // print(AppConfig.projects);

    try {
      final response = await http.get(Uri.parse("${AppConfig.projects}/1"),
          headers: AppConfig.requestHeaders);
      final data = json.decode(response.body);
      // print(data);
      if (response.statusCode == 200) {
        clientnameController.text =
            data['message']['record']['clientname'].toString();
        projectnameController.text =
            data['message']['record']['projectname'].toString();
        projectdescriptionController.text =
            data['message']['record']['projectdescription'].toString();
        stagesController.text = data['message']['record']['stages'].toString();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
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
                  hintText: "Enter Clients name",
                  labelText: "Client Name",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
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
                    Icons.file_copy,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  hintText: "Enter Project Name",
                  labelText: "Project Name",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "Enter Project Description",
                  labelText: "Project Description",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "DD/MM/YY",
                  labelText: "start date",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "DD/MM/YY",
                  labelText: "Due date",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 109))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.addchart,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: " Stages ",
                  labelText: "Stages",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text("Create"),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text("Delete"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
