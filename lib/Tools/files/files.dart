import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';

import '../links/link_form_page.dart';
import '../../custom_appbar.dart';
import '../../custom_snackbar.dart';

// ignore: must_be_immutable
class Files extends StatefulWidget {
  final int? id;
  final String? model;
  const Files({
    super.key,
    this.id,
    required this.model,
  });

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  bool isLoading = true;
  late List items = [];
  final TextEditingController _searchController = TextEditingController();
  List filteredItems = [];
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
        title: const Text("Files"),
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
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index] as Map;
                        // final id = item['_id'] as int;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 97, 8, 119),
                            child: Text('${index + 1}'),
                          ),
                          title: GestureDetector(
                            onTap: () {},
                            // child: Text('Title'),
                            child: Text(item['name']),
                          ),
                          subtitle: Text(item['path']),
                          trailing: SizedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigateToLinkFormPage();
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
        onPressed: navigateToLinkFormPage,
        label: const Text(
          "Add Files",
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
      var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/files';
      // print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      if (response.statusCode == 200) {
        // print("--------------------");
        // print(response.body);
        final result = jsonDecode(response.body) as Map;
        // print(result);
        setState(() {
          items = result['message']['record']['files'];
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

  Future<void> navigateToLinkFormPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => LinkFormPage(
        id: id,
        model: 'model',
      ),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }
}
