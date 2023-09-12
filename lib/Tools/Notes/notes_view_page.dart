import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../custom_appbar.dart';
import '../../custom_snackbar.dart';

class NotesViewPage extends StatefulWidget {
  final int? id;
  final String? model;
  const NotesViewPage({
    super.key,
    this.id,
    this.model,
  });

  @override
  State<NotesViewPage> createState() => _NotesViewPageState();
}

class _NotesViewPageState extends State<NotesViewPage> {
  bool isLoading = true;
  String title = "";
  String description = "";
  String model = "";
  // String contactnumber = "";
  // String emailaddress = '';
  List items = [];

  @override
  void initState() {
    super.initState();

    // if (widget.id != null) {}
    fetchTodo();
    // fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Notes View"),
        actions: const <Widget>[CustomAppBar()],
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView(children: [
          // ListView.builder(
          //   itemCount: items.length,
          //   itemBuilder: (context, index) {
          //     return const ListTile(
          //       title: Text('test'),
          //     );
          //   },
          // ),
          const SizedBox(
            height: 20,
            width: 10,
          ),
          Card(
            child: SizedBox(
              height: 120,
              child: Text(
                // "title:Sahasrara MetaTech Pvt Ltd",
                // (List<String> items = ['']) as String;
                'title:$title \ndescription:$description',

                // title,
                semanticsLabel: model.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Card(
          //   child: Column(
          //     children: <Widget>[
          //       ListTile(
          //         title: const Text("Links"),
          //         trailing: const Icon(Icons.keyboard_arrow_right),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => Links(
          //                 id: widget.id,
          //                 model: model,
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // Card(
          //   child: Column(
          //     children: <Widget>[
          //       ListTile(
          //         title: const Text("Notes"),
          //         trailing: const Icon(Icons.keyboard_arrow_right),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => Notes(
          //                       id: widget.id,
          //                       model: model,
          //                     )),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // Card(
          //   child: Column(
          //     children: <Widget>[
          //       ListTile(
          //         title: const Text("Files"),
          //         trailing: const Icon(Icons.keyboard_arrow_right),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => Files(
          //                       id: widget.id,
          //                       model: model,
          //                     )),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          // SizedBox(
          //   height: 200,
          //   child: ProjectListWidget(
          //     items: items,
          //     // fetchTodo: fetchTodo,
          //     // navigateToFormPage: navigateToProjectsListPage,
          //   ),
          //   // child: Text('hello'),
          //   // child: Text(
          //   //   "Projects",
          //   //   // semanticsLabel: items[0]['title'],
          //   //   // (List<String> items = ['']) as String;
          //   //   // title, semanticsLabel: description,
          //   //   // semanticsLabel: model.toString(),
          //   //   textAlign: TextAlign.start,
          //   //   style: TextStyle(
          //   //       color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
          //   // ),
          // ),

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
          //       items[0]['title'],
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
          //         child: const Text('item title'),
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
      // const url = 'AppConfig.clients/id';y
      var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/note';
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      if (response.statusCode == 200) {
        //   // print(response.body);
        final result = jsonDecode(response.body);
        // print(result);
        // final data = result['message']['record']['title'];

        // // print(data);

        setState(() {
          title = result['message']['record']['notes']['title'];
          description = result['message']['record']['description'];
          model = result['message']['model_type'];

          // contactnumber = result['message']['record']['phone'];
          // emailaddress = result['message']['record']['email'];

          items = result['message']['record']['notes'];
          // print(items);
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

  // Future<void> fetchProject() async {
  //   // final header = {
  //   //   'Content-type': 'application/json',
  //   //   'Accept': 'application/json',
  //   // };

  //   try {
  //     // const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //     // const url = AppConfig.projects;
  //     var url = '${AppConfig.projects}/${widget.id}?withAttach';

  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: AppConfig.requestHeaders,
  //     );

  //     if (response.statusCode == 200) {
  //       // print(response.body);
  //       final result = jsonDecode(response.body) as Map;
  //       setState(() {
  //         items = result['message']['model'] as List;
  //       });
  //       // print(response.body);
  //     } else {
  //       throw (jsonDecode(response.body)['message']);
  //     }
  //   } catch (e) {
  //     debugPrint('$e');
  //     CustomSnackBar.show(
  //       context,
  //       message: '$e',
  //       bgColor: Colors.red,
  //     );
  //   }
  // }

  // Future<void> navigateToProjectsListPage({int? id}) async {
  //   final route = MaterialPageRoute(
  //     builder: (context) => ProjectListPage(id: id),
  //   );
  //   await Navigator.push(context, route);
  //   fetchTodo();
  //   // fetchProject();
  // }
}
