import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssm_app/Activity/activity_widget.dart';
import 'package:ssm_app/custom_snackbar.dart';
import 'package:http/http.dart' as http;

import '../Tools/Notes/notes_list_page.dart';
import '../Tools/files/files.dart';
import '../Tools/links/links.dart';
import '../config.dart';

class TaskViewPage extends StatefulWidget {
  final int? id;
  final String? model;
  const TaskViewPage({
    super.key,
    this.id,
    this.model,
  });
  // const TaskViewPage({super.key, int? id});

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  bool isLoading = true;
  List items = [];

  String name = "";
  String description = "";
  String startdate = "";
  String duedate = "";
  String model = "";

  @override
  void initState() {
    super.initState();

    // if (widget.id != null) {}
    // fetchTodo();
    // fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Task View"),
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView(children: [
          const SizedBox(
            height: 20,
            width: 10,
          ),
          Card(
            child: SizedBox(
              // height: 320,
              child: Text(
                // "name:Sahasrara MetaTech Pvt Ltd",
                // (List<String> items = ['']) as String;
                'Name:$name  \nDescription:$description  \nStartdate:$startdate \nDuedate:$duedate',

                // name,
                // semanticsLabel: model.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text("Links"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Links(
                          id: widget.id,
                          model: model,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text("Notes"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Notes(
                                // id: widget.id,
                                id: widget.id,
                                model: model,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text("Files"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Files(
                                id: widget.id,
                                model: model,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 200,
            child: ActivityWidget(
              items: items,
              // fetchTodo: fetchTodo,
              // navigateToFormPage: navigateToProjectsListPage,
            ),
            // child: Text('hello'),
            // child: Text(
            //   "Projects",
            //   // semanticsLabel: items[0]['name'],
            //   // (List<String> items = ['']) as String;
            //   // name, semanticsLabel: alias,
            //   // semanticsLabel: model.toString(),
            //   textAlign: TextAlign.start,
            //   style: TextStyle(
            //       color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
            // ),
          ),

          const SizedBox(
            height: 30,
          ),
          // const Card(
          //   child: ProjectListWidget(),
          // )
          // ProjectWidget(
          //     isLoading: isLoading,
          //     items: items,
          //     navigateToFormPage: navigateToProjectsListPage)
          // Card(
          //   child: SizedBox(
          //     height: 180,
          //     child: Text(
          //       items[0]['name'],
          //       textAlign: TextAlign.start,
          //       style: TextStyle(
          //           color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
          //     ),
          //   ),
          // ),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(15),
          // child: ListView.builder(
          //   itemCount: items.length,
          //   itemBuilder: (context, index) {
          //     // final item = items[index];
          //     // final id = item['id'] as int;
          //     return ListTile(
          //       leading: CircleAvatar(
          //         backgroundColor: const Color.fromARGB(255, 97, 8, 119),
          //         child: Text('${index + 1}'),
          //       ),
          //       title: GestureDetector(
          //         onTap: () {},
          //         child: const Text('item name'),
          //       ),
          //       // subtitle: Text(item['']),
          //     );
          //   },
          // ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  Future<void> fetchTodo() async {
    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      // const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      // const url = 'AppConfig.names/id';
      var url = '${AppConfig.tasks}/${widget.id}?withAttach';
      // print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      if (response.statusCode == 200) {
        //   // print(response.body);
        final result = jsonDecode(response.body);
        // print(result);
        // final data = result['message']['record']['name'];

        // // print(data);

        setState(() {
          name = result['message']['record']['name'];
          description = result['message']['record']['description'];
          model = result['message']['model'];

          startdate = result['message']['record']['start_date'];
          duedate = result['message']['record']['due_date'];

          items = result['message']['record']['activities'];
          // print(result['message']['record']);
        });
        // print(response.body);
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
}
