import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssm_app/unused%20files/database_helper.dart';
import 'package:ssm_app/config.dart';
import 'package:http/http.dart' as http;

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  Future fetchClientDetails() async {
    // print(AppConfig.clients);

    try {
      final response = await http.get(Uri.parse("${AppConfig.clients}/1"),
          headers: AppConfig.requestHeaders);
      final data = json.decode(response.body);
      // print(data);
      if (response.statusCode == 200) {
        _nameController.text = data['message']['record']['name'].toString();
        _descController.text = data['message']['record']['desc'].toString();
        // phoneController.text = data['message']['record']['phone'].toString();
        // emailController.text = data['message']['record']['email'].toString();
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

      // var errorMessage = 'Failed to load client details \r\n $e';
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(errorMessage)),
      // );
    }
  }

  // @override
  // void initState() {
  //   print("=====================");
  //   if (!AppConfig.offline) {
  //     fetchClientDetails();
  //   } else {
  //     print("Work on offline method.");
  //   }
  //   super.initState();
  //   // check_if_already_login();
  // }

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshData();
  }

  // ignore: unused_element
  Future<void> _addData() async {
    await SQLHelper.createData(1, _nameController.text, _descController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
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
            // ElevatedButton(onPressed: (){

            // }, child:  Padding(
            //       padding: EdgeInsets.all(18),
            //       child: Text(
            //           "Update",
            //         style: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),)
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       if (id == null) {
            //         await _addData();
            //       }
            //       if (id != null) {
            //         await _updateData(id);
            //       }
            //       _nameController.text = "";
            //       _descController.text = "";
            //       // ignore: use_build_context_synchronously
            //       Navigator.of(context).pop();
            //       // print("Data Added");
            //     },
            //   child: Padding(
            //     padding: EdgeInsets.all(18),
            //     child: Text(
            //       id == null ? "Add Data" : "Update",
            //       style: const TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
            // )
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
