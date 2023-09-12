import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';
import '../../custom_appbar.dart';
import '../../custom_snackbar.dart';
import 'link_form_page.dart';
import 'link_view_page.dart';

// import 'package:url_launcher/link.dart';
// import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Links extends StatefulWidget {
  final int? id;
  final String? model;
  const Links({
    super.key,
    this.id,
    required this.model,
  });

  @override
  State<Links> createState() => _LinksState();
}

class _LinksState extends State<Links> {
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
                rec['url']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Links"),
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
                              navigateToLinkViewPage(
                                id: id,
                                model: model,
                              );
                              // final url = item['slug'];
                              // if (await canLaunch(url)) {
                              //   await launch(url);
                              // } else {
                              //   throw 'Could not launch $url';
                              // }
                              // html.AnchorElement anchor =
                              //     new html.AnchorElement(href: item['slug']);
                              // anchor.target = '_blank';
                              // anchor.click();
                            },
                            // child: Text('Title'),
                            child: Text(item['title']),
                          ),
                          subtitle: GestureDetector(
                            onTap: () {
                              navigateToLinkViewPage(id: id, model: model);
                            },
                            child: Text(item['slug']),
                          ),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigateToLinkFormPage(id: id);
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
          "Add Links",
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
      var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/urls';
      // print(widget.model);
      print(url);

      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );
      // print(response.body);

      if (response.statusCode == 200) {
        // print("--------------------");
        // print(response.body);
        final result = jsonDecode(response.body) as Map;
        // print(response.body);
        setState(() {
          items = result['message']['record']['urls'];
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

  // launch(url) {}

  // canLaunch(url) {}

  Future<void> navigateToLinkViewPage({int? id, required model}) async {
    final route = MaterialPageRoute(
      builder: (context) => LinkViewPage(id: id),
    );
    await Navigator.push(context, route);
    fetchTodo();
  }
}
