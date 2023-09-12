// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:ssm_app/unused%20files/task_database_helper.dart';

// ignore: camel_case_types
class taskScreen extends StatefulWidget {
  const taskScreen({super.key});

  @override
  State<taskScreen> createState() => _taskScreenState();
}

// ignore: camel_case_types
class _taskScreenState extends State<taskScreen> {
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _projectnameController = TextEditingController();
  final TextEditingController _tasknameController = TextEditingController();

  final TextEditingController _taskdescController = TextEditingController();
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();
  final TextEditingController _stagesController = TextEditingController();

  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  Future fetchClientDetails() async {
    print(AppConfig.tasks);

    try {
      final response = await http.get(Uri.parse("${AppConfig.tasks}/1"),
          headers: AppConfig.requestHeaders);
      final data = json.decode(response.body);
      // print(data);
      if (response.statusCode == 200) {
        _clientnameController.text =
            data['message']['record']['clientname'].toString();
        _projectnameController.text =
            data['message']['record']['projectname'].toString();
        _tasknameController.text =
            data['message']['record']['projectdesc'].toString();
        _tasknameController.text =
            data['message']['record']['taskdesc'].toString();
        _startdateController.text =
            data['message']['record']['startdate'].toString();
        _enddateController.text =
            data['message']['record']['enddate'].toString();
        _stagesController.text =
            data['messa5ge']['record']['stages'].toString();

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

      var errorMessage = 'Failed to load tasks details \r\n $e';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void updateData(
    int id,
    String clientname,
    String projectname,
    String taskname,
    String taskdesc,
    DateTime startdate,
    DateTime enddate,
    List<String> stages,
  ) {
    _updateData(id, clientname, projectname, taskname, taskdesc, startdate,
        enddate, stages);
  }

  Future _refreshData() async {
    try {
      print(AppConfig.tasks);
      final response = await http.get(Uri.parse(AppConfig.tasks),
          headers: AppConfig.requestHeaders);
      final resp = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(resp);
        var records = resp['message']['records'];
        // print(records[0]['name']);
        await TASKSQLHELPER.deleteAllData();
        for (var record in records) {
          await TASKSQLHELPER.createData(
            record['id'],
            record['clientname'],
            record['projectname'],
            record['taskname'],
            record['taskdesc'],
            record['startdate'],
            record['enddate'],
            record['stages'],
          );
        }
        // await TASKSQLHELPER.updateData();
        // for (var record in records) {
        //   await TASKSQLHELPER.updateData(
        //       record['name'], record['alias'], record['createdAt']);
        // }

        // return throw Exception('Failed to load profile details');

        //     var errorMessage = 'Failed to load client details \r\n $e';
        // ignore: use_build_context_synchronously
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(errorMessage)),
        // );
        //   }
        // }

        // insert each record into database

        // await TASKSQLHELPER.InsertData('data', 'data');
        // loop  => resp['message']['record']
        // ['id'].toString();
        // ['name'].toString();
        // ['desc'].toString();
        // // phoneController.text = data['message']['record']['phone'].toString();
        //           // emailController.text = data['message']['record']['email'].toString();
      } else {
        var errorMessage = resp['errors'];
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      var errorMessage = 'Failed to load client details \r\n $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    @override
    // void initState() {}
        final data = await TASKSQLHELPER.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  Future<void> _updateData(
    int id,
    String clientname,
    String projectname,
    String taskname,
    String taskdesc,
    DateTime startdate,
    DateTime enddate,
    List<String> stages,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        "id": id,
        "clientname": clientname,
        'projectname': projectname,
        'taskname': taskname,
        'taskdesc': taskdesc,
        'startdate': startdate,
        'enddate': enddate,
        'stages': stages,
      };

      final response = await http.put(
        Uri.parse("${AppConfig.tasks}/$id"),
        headers: AppConfig.requestHeaders,
        body: json.encode(requestBody), // Convert the map to JSON string
      );

      final resp = json.decode(response.body);

      if (response.statusCode == 200) {
        // Data updated successfully. Handle success case if needed.
        print("Data updated successfully.");
      } else {
        // Data update failed. Handle failure case if needed.
        var errorMessage = resp['errors'];
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      var errorMessage = 'Failed to update data \r\n $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshData();
  // }

  Future<void> _addData() async {
    // final response = await http.post(Uri.parse(AppConfig.projects));

    // await TASKSQLHELPER.createData(1,_nameController.text, _descController.text);
    _refreshData();
  }

  // Future<void> _updateData(
  //   int id,
  //   String text,
  //   String,
  // ) async {
  //   final response = await http.put(Uri.parse(AppConfig.projects));

  //   // await TASKSQLHELPER.updateData(id, _nameController.text, _descController.text);
  //   _refreshData();
  // }

  void _deleteData(int id) async {
    await TASKSQLHELPER.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Data Deleted"),
    ));
    _refreshData();
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _clientnameController.text = existingData['clientname'];
      _projectnameController.text = existingData['projectname'];
      _tasknameController.text = existingData['taskname'];
      _taskdescController.text = existingData['taskdesc'];
      _startdateController.text = existingData['startdate'];
      _enddateController.text = existingData['enddate'];
      _stagesController.text = existingData['stages'];
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              onChanged: (String value) {
                setState(() {});
              },
              onTap: () {},
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _clientnameController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "client name",
                labelText: 'Client Name',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _projectnameController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "project name",
                labelText: 'Project Name',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _tasknameController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "task name",
                labelText: 'task name',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _taskdescController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "task desc",
                labelText: 'task desc',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _startdateController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "Start Date",
                labelText: 'Start Date',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),

            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _enddateController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: "End date",
                labelText: 'End Date',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _stagesController,
              // maxLines: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 97, 8, 119),
                )),
                border: OutlineInputBorder(),
                hintText: " Stages",
                labelText: 'stages',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addData();
                    }
                    _clientnameController.text = "";
                    _projectnameController.text = "";
                    _tasknameController.text = "";
                    _taskdescController.text = "";
                    _startdateController.text = "";
                    _enddateController.text = "";
                    _stagesController.text = "";

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      id == null ? "Add Data" : "Cancel",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Add some space between the buttons
            if (id != null)
              ElevatedButton(
                onPressed: () async {
                  // updateData(id, _nameController.text, _descController.text);
                  await _updateData(
                    id,
                    _clientnameController.text,
                    _projectnameController.text,
                    _tasknameController.text,
                    _taskdescController.text,
                    _startdateController.text as DateTime,
                    _enddateController.text as DateTime,
                    _stagesController.text as List<String>,
                  );
                  _clientnameController.text = "";
                  _projectnameController.text = "";
                  _taskdescController.text = "";

                  _taskdescController.text = "";
                  _startdateController.text = "";
                  _enddateController.text = "";
                  _stagesController.text = "";
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       if (id == null) {
            //         await _addData();
            //       } else {
            //         await _updateData(
            //             id, _nameController.text, _descController.text);
            //       }
            //       _nameController.text = "";
            //       _descController.text = "";
            //       Navigator.of(context).pop();
            //       // print("Data Added");
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(18),
            //       child: Text(
            //         id == null ? "Add Data" : "Update",
            //         style: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEAF4),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Task's"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          _allData[index]['name'],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      subtitle: Text(_allData[index]['desc']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showBottomSheet(_allData[index]['id']);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteData(_allData[index]['id']);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        foregroundColor: Colors.white,
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
