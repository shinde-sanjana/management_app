import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';

import '../../custom_appbar.dart';
import '../../custom_snackbar.dart';
import 'notes_form_page.dart';
import 'notes_view_page.dart';

// ignore: must_be_immutable
class Notes extends StatefulWidget {
  final int? id;
  final String? model;
  const Notes({
    super.key,
    this.id,
    this.model,
  });

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool isLoading = true;
  // String title = "";
  // String description = "";
  final TextEditingController _searchController = TextEditingController();
  List filteredItems = [];

  late List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
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
                rec['title']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                rec['description']
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Note's Page"),
        toolbarHeight: 40,
        actions: const <Widget>[CustomAppBar()],
      ),
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
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index] as Map;
                        final model = item['model'];
                        final id = item['id'] as int;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 97, 8, 119),
                            child: Text('${index + 1}'),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              navigateToNotesViewPage(
                                id: id,
                                model: model,
                              );
                            },
                            child: Text(
                              item['title'].toString(),
                            ),
                          ),
                          subtitle: GestureDetector(
                            onTap: () {
                              navigateToNotesViewPage(
                                id: id,
                                model: model,
                              );
                            },
                            child: Text(
                              item['description'].toString(),
                              maxLines: 5,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigateToNotesFormPage(id: id);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        onPressed: navigateToNotesFormPage,
        label: const Text(
          "Add Notes",
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
      var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/notes';
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      // print(response.body);

      if (response.statusCode == 200) {
        // print("--------------------");
        final result = jsonDecode(response.body) as Map;
        // print(result);
        setState(() {
          items = result['message']['record']['notes'];
          // print(items);
        });
        filterItems(_searchController.text);
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

  Future<void> navigateToNotesFormPage({
    int? id,
  }) async {
    final route = MaterialPageRoute(
      builder: (context) => NotesFormPage(
        id: id,
        model: 'model',
      ),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }

  Future<void> navigateToNotesViewPage({int? id, required String model}) async {
    // print(id);
    final route = MaterialPageRoute(
      builder: (context) => NotesViewPage(
        id: id,
        model: model,
      ),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }
}
