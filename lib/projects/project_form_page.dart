// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config.dart';
import '../custom_appbar.dart';
import '../custom_snackbar.dart';

class ProjectFormPage extends StatefulWidget {
  final int? id;
  const ProjectFormPage({
    super.key,
    this.id,
  });

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController projectnameController = TextEditingController();
  TextEditingController clientnameController = TextEditingController();
  TextEditingController projectleadController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController duedateController = TextEditingController();

  bool isEdit = false;
  bool autoValidate = true;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      isEdit = true;
      fetchTodo(widget.id as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: Text(
          isEdit ? 'Edit project' : 'Add project',
        ),
        actions: const <Widget>[CustomAppBar()],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Client Name can't be empty";
                  } else {
                    return "Client Name is required";
                  }
                },
                controller: clientnameController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    hintText: 'Client',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 8,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Projectname can't be empty";
                  } else {
                    return "Projectname is required";
                  }
                },
                controller: projectnameController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: 'Projectname',
                  prefixIcon: Icon(
                    Icons.folder,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Project lead can't be empty";
                  } else {
                    return "Project lead is required";
                  }
                },
                controller: projectleadController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: 'Project lead',
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 8,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Description can't be empty";
                  } else {
                    return "Description is required";
                  }
                },
                controller: descriptionController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: 'Description',
                  prefixIcon: Icon(
                    Icons.description,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 8,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "StartDate can't be empty";
                  } else {
                    return "StartDate is required";
                  }
                },
                controller: startdateController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: 'StartDate',
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 8,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "DueDate can't be empty";
                  } else {
                    return "DueDate is required";
                  }
                },
                controller: duedateController,
                cursorColor: const Color.fromARGB(255, 97, 8, 119),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: 'DueDate',
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 8,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                ),
                onPressed: submitData,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    isEdit ? 'Update' : 'Create',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchTodo(int id) async {
    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      // const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      var url = '${AppConfig.projects}/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        projectnameController.text = result['message']['record']['name'];
        clientnameController.text = result['message']['record']['alias'];
      } else {
        throw (jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('$e');
      CustomSnackBar.show(
        context,
        message: '$e',
        bgColor: Colors.red,
      );
    }
  }

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {}
    final name = projectnameController.text;
    final alias = clientnameController.text;

    final body = {
      "name": name,
      "alias": alias,
    };

    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      var url = widget.id != null
          ? '${AppConfig.projects}/${widget.id}'
          : AppConfig.projects;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));

      final result = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          projectnameController.text = '';
          clientnameController.text = '';
        }

        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          message:
              "Projects ${widget.id != null ? 'updated' : 'added'} successfully.",
        );
      } else {
        throw (result['message']);
      }
    } catch (e) {
      CustomSnackBar.show(context, message: '$e', bgColor: Colors.red);
    }
  }

  // void showMessage(String message, {Color? bgColor}) {
  //   final snackBar = SnackBar(
  //     content: Text(
  //       message,
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //     backgroundColor: bgColor ?? Colors.green,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
