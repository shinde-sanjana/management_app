// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config.dart';
import '../custom_appbar.dart';
import '../custom_snackbar.dart';

class TaskFormPage extends StatefulWidget {
  final int? id;
  final String model;

  const TaskFormPage({
    super.key,
    this.id,
    required this.model,
  });

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController clientnameController = TextEditingController();
  TextEditingController projectnameController = TextEditingController();
  TextEditingController assigntoController = TextEditingController();
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
          isEdit ? 'Edit Task' : 'Add Task',
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
                    return "Client name can't be empty";
                  } else {
                    return " Client name is required";
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
                    hintText: 'Client name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Project name can't be empty";
                  } else {
                    return "Project name is required";
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
                  hintText: 'Project name',
                  prefixIcon: Icon(
                    Icons.folder,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return " Task name can't be empty";
                  } else {
                    return "Task name is required";
                  }
                },
                controller: nameController,
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
                  hintText: 'Task name',
                  prefixIcon: Icon(
                    Icons.person_3_outlined,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Assign to can't be empty";
                  } else {
                    return "Assign to is required";
                  }
                },
                controller: assigntoController,
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
                  hintText: 'Assign To',
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
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
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Date can't be empty";
                  } else {
                    return "Start Date is required";
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
                  hintText: 'Start Date',
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Date can't be empty";
                  } else {
                    return " Due Date is required";
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
                  hintText: 'Due Date',
                  prefixIcon: Icon(
                    Icons.date_range_rounded,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
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
      var url = '${AppConfig.tasks}/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        nameController.text = result['message']['record']['name'];
        clientnameController.text = result['message']['record']['client name'];
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

    final name = nameController.text;
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
          ? '${AppConfig.tasks}/${widget.id}'
          : AppConfig.tasks;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));

      final result = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          nameController.text = '';
          clientnameController.text = '';
        }

        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          message:
              "tasks ${widget.id != null ? 'updated' : 'added'} successfully.",
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
