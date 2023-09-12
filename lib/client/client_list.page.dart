import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssm_app/custom_appbar.dart';
import 'dart:convert';

import '../config.dart';
import '../custom_snackbar.dart';
import '../navbar.dart';
import 'client_form_page.dart';
import 'client_view_page.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  bool isLoading = true;
  late List items = [];
  final TextEditingController _searchController = TextEditingController();
  List filteredItems = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
    // filterItems("");
  }

  filterItems(String query) {
    // print("query");
    // String query = _searchController.text;
    setState(() {
      if (query.isEmpty) {
        filteredItems = List.from(items);
      } else {
        filteredItems = items
            .where((rec) =>
                rec['name']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                rec['alias']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Client's List"),
        toolbarHeight: 40,
        actions: const <Widget>[
          CustomAppBar(),
        ],
      ),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      //   title: const Text("Client's List"),
      // ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: filterItems,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchTodo,
                  child: ListView.builder(
                    // itemCount: filteredItems.length,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      // final item = filteredItems[index] as Map;

                      final item = filteredItems[index] as Map;
                      final id = item['id'] as int;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 97, 8, 119),
                          child: Text('${index + 1}'),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            navigateToViewPage(id: id);
                          },
                          child: Text(
                            item['name'].toString(),
                          ),
                        ),
                        subtitle: Text(
                          item['alias'].toString(),
                        ),
                        trailing: SizedBox(
                          width: 70,
                          child: Row(
                            children: [
                              // GestureDetector(
                              //   onTap: () {
                              //     navigateToViewPage(id: id);
                              //   },
                              //   child: Container(
                              //     child: const Icon(
                              //       Icons.assignment,
                              //       size: 24,
                              //     ),
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  navigateToFormPage(id: id);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 24,
                                ),
                              ),
                              // if (item['can_edit'])
                              //   IconButton(
                              //     tooltip: 'Edit',
                              //     icon: const Icon(Icons.edit),
                              //     onPressed: () {
                              //       navigateToFormPage(id: id);
                              //     },
                              //   ),
                              //   if (item['can_view'])
                              //     IconButton(
                              //       tooltip: 'view',
                              //       icon: const Icon(Icons.description),
                              //       onPressed: () {
                              //         navigateToFormPage(id: id);
                              //       },
                              //     ),
                            ],
                          ),
                        ),

                        // trailing: PopupMenuButton(
                        //   onSelected: (value) {
                        //     if (value == 'edit') {
                        //       navigateToFormPage(id: id);
                        //     } else if (value == 'delete') {
                        //       deleteByID(id);
                        //     }
                        //   },
                        //   itemBuilder: (context) {
                        //     return [
                        //       PopupMenuItem(
                        //         value: 'edit',
                        //         child: Text(item['can_edit'] ? "Yes" : "No"),
                        //       ),
                        //       const PopupMenuItem(
                        //         value: 'delete',
                        //         child: Text('Delete'),
                        //       ),
                        //     ];
                        //   },
                        // ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        onPressed: navigateToFormPage,
        label: const Text(
          "Add client",
        ),
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
      const url = AppConfig.clients;
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      if (response.statusCode == 200) {
        // print(response.body);
        final result = jsonDecode(response.body) as Map;
        setState(() {
          items = result['message']['records'] as List;
        });
        filterItems(_searchController.text);

        // print("fetchTodo");
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

  Future<void> navigateToFormPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => ClientFormPage(id: id),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }

  Future<void> navigateToViewPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => ClientViewPage(id: id),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }

  // Future<void> deleteByID(int id) async {
  //   // final header = {
  //   //   'Content-type': 'application/json',
  //   //   'Accept': 'application/json',
  //   // };

  //   try {
  //     final url = '${AppConfig.clients}/$id';
  //     final response = await http.delete(
  //       Uri.parse(url),
  //       headers: AppConfig.requestHeaders,
  //     );
  //     // print(response.body);
  //     if (response.statusCode == 200) {
  //       final filtteredItems =
  //           items.where((element) => element['id'] != id).toList();
  //       setState(() {
  //         items = filtteredItems;
  //       });

  //       // ignore: use_build_context_synchronously
  //       CustomSnackBar.show(
  //         context,
  //         message: "Record deleted successfully.",
  //       );
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
}
