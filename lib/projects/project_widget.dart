import 'package:flutter/material.dart';

import 'package:ssm_app/projects/project_form_page.dart';
import 'package:ssm_app/projects/project_view_page.dart';

class ProjectListWidget extends StatefulWidget {
  final List<dynamic> items;

  // final List items;
  // const ProjectListWidget({Key? key}) : super(key: key);
  const ProjectListWidget({
    super.key,
    required this.items,
    // required Future<void> Function({int? id}) navigateToFormPage,
    // required Future<void> Function() fetchTodo,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  bool isLoading = true;
  // List items = [];

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
                            builder: (context) => ProjectViewPage(
                                  id: id,
                                )));

                    //   Navigate.
                  },
                  child: Text(item['name'])),
              // subtitle: Text(item['client']['name']),
              trailing: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    if (item['can_edit'])
                      IconButton(
                        tooltip: 'Edit',
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          navigateToFormPage(id: id);
                        },
                      )
                  ],
                ),
              ),
            );
          },
        ),
        // ),
      ),
    );
  }

  // Future<void> fetchTodo() async {
  //   try {
  //     const url = AppConfig.projects;
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: AppConfig.requestHeaders,
  //     );

  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(response.body) as Map;
  //       setState(() {
  //         items = result['message']['records'] as List;
  //       });
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

  Future<void> navigateToFormPage({int? id}) async {
    final route = MaterialPageRoute(
      builder: (context) => ProjectFormPage(id: id),
    );
    await Navigator.push(context, route);
    // fetchTodo();
  }
}
