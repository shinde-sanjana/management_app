import 'package:flutter/material.dart';
import 'package:ssm_app/task/task_form_page.dart';
import 'package:ssm_app/task/task_view_page.dart';

class TaskWidget extends StatefulWidget {
  final List<dynamic> items;
  const TaskWidget({
    super.key,
    required this.items,
  });
  // const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
        // child: RefreshIndicator(
        //   onRefresh: fetchTodo,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskViewPage(
                                id: id,
                              )));
                },
                child: Text(
                  item['name'].toString(),
                ),
              ),
              // subtitle: Text(
              //   item['project']['client']['name'].toString(),
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
    );
  }

  Future<void> navigateToFormPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => TaskFormPage(
        id: id,
        model: 'model',
      ),
    );
    await Navigator.push(context, route);
    // fetchTodo();
  }
}
