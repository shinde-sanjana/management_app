import 'package:flutter/material.dart';

import 'activity_form_page.dart';
import 'activity_view_page.dart';

class ActivityWidget extends StatefulWidget {
  final List<dynamic> items;
  const ActivityWidget({
    super.key,
    required this.items,
  });

  // const ActivityWidget({super.key});

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // items = widget.items;
    // print(widget.items);
    // fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];

            // final item = items[index] as Map;
            final id = item['id'] as int;

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                child: Text('${index + 1}'),
              ),
              title: GestureDetector(
                onTap: () {
                  // navigateToViewPage(id: id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActivityViewPage(
                                id: id,
                              )));
                },
                child: Text(
                  item['description'].toString(),
                ),
              ),
              // subtitle: Text(
              //   item['project']['description'].toString(),
              // ),
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
            );
          },
        ),
      ),
    );
  }

  Future<void> navigateToFormPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => ActivityFormPage(id: id),
    );
    await Navigator.push(context, route);
    // fetchTodo();
  }
}
