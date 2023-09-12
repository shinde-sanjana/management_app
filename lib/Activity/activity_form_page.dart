// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ssm_app/config.dart';

import '../custom_appbar.dart';
import '../custom_snackbar.dart';

class ActivityFormPage extends StatefulWidget {
  final int? id;
  const ActivityFormPage({
    super.key,
    this.id,
  });

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController clientnameController = TextEditingController();
  TextEditingController projectnameController = TextEditingController();
  TextEditingController tasknameController = TextEditingController();
  TextEditingController dateCotroller = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController stagesController = TextEditingController();

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
          isEdit ? 'Edit Activity' : 'Add Activity',
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
                    return "Client Name is required ";
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
                    hintText: 'Client Name',
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
                    return "Project Name can't be empty";
                  } else {
                    return "Project Name is required ";
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
                  hintText: 'Project Name',
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
                    return "Task Name can't be empty";
                  } else {
                    return "Task Nameis required ";
                  }
                },
                controller: tasknameController,
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
                  hintText: 'Task Name',
                  prefixIcon: Icon(
                    Icons.person_3_outlined,
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
                    return "Date is required ";
                  }
                },
                controller: dateCotroller,
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
                  hintText: 'Date',
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Start Time can't be empty";
                  } else {
                    return "Start Timeis required ";
                  }
                },
                controller: starttimeController,
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
                  hintText: 'Start Time',
                  prefixIcon: Icon(
                    Icons.timer,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "End Time can't be empty";
                  } else {
                    return "End Time is required";
                  }
                },
                controller: endtimeController,
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
                  hintText: 'End Time',
                  prefixIcon: Icon(
                    Icons.timer,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Duration can't be empty";
                  } else {
                    return "duration is required";
                  }
                },
                controller: durationController,
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
                  hintText: 'duration',
                  prefixIcon: Icon(
                    Icons.lock_clock,
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
      var url = '${AppConfig.activity}/$id';
      // print(AppConfig.requestHeaders);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        dateCotroller.text = result['message']['record']['date'];
        durationController.text = result['message']['record']['duration'];
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
    final date = dateCotroller.text;
    final duration = durationController.text;

    final body = {
      "date": date,
      "duration": duration,
    };

    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      var url = widget.id != null
          ? '${AppConfig.activity}/${widget.id}'
          : AppConfig.activity;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));

      final result = jsonDecode(response.body);
      // print(result);
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          dateCotroller.text = '';
          durationController.text = '';
        }

        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          message:
              "Client ${widget.id != null ? 'updated' : 'added'} successfully.",
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
