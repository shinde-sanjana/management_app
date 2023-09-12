// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssm_app/unused%20files/database_helper.dart';
import 'package:ssm_app/config.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class clientScreen extends StatefulWidget {
  const clientScreen({super.key});

  @override
  State<clientScreen> createState() => _clientScreenState();
}

// ignore: camel_case_types
class _clientScreenState extends State<clientScreen> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void updateData(
    int id,
    String name,
    String desc,
  ) {
    _updateData(id, name, desc);
  }

  Future _refreshData() async {
    try {
      print(AppConfig.clients);
      final response = await http.get(Uri.parse(AppConfig.clients),
          headers: AppConfig.requestHeaders);
      final resp = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(resp);
        var records = resp['message']['records'];
        // print(records[0]['name']);
        await SQLHelper.deleteAllData();
        for (var record in records) {
          await SQLHelper.createData(
            record['id'],
            record['name'],
            record['alias'],
          );
        }
        // await SQLHelper.updateData();
        // for (var record in records) {
        //   await SQLHelper.updateData(
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

        // await SQLHelper.InsertData('data', 'data');
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
        final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  Future<void> _updateData(int id, String name, String desc) async {
    try {
      final Map<String, dynamic> requestBody = {
        "name": name,
        "desc": desc,
      };

      final response = await http.put(
        Uri.parse("${AppConfig.clients}/$id"),
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
    // final response = await http.post(Uri.parse(AppConfig.clients));

    await SQLHelper.createData(1, _nameController.text, _descController.text);
    _refreshData();
  }

  // Future<void> _updateData(
  //   int id,
  //   String text,
  //   String,
  // ) async {
  //   final response = await http.put(Uri.parse(AppConfig.clients));

  //   // await SQLHelper.updateData(id, _nameController.text, _descController.text);
  //   _refreshData();
  // }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Data Deleted"),
    ));
    _refreshData();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _nameController.text = existingData['name'];
      _descController.text = existingData['desc'];
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
              controller: _nameController,
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
                hintText: "name",
                labelText: 'Client Name',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              controller: _descController,
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
                hintText: "Alias",
                labelText: 'Alias Name',
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
                    _nameController.text = "";
                    _descController.text = "";
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
                      id, _nameController.text, _descController.text);
                  _nameController.text = "";
                  _descController.text = "";
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
        title: const Text("Client's"),
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
