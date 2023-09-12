import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssm_app/custom_snackbar.dart';

import '../../config.dart';
import '../../custom_appbar.dart';

class LinkFormPage extends StatefulWidget {
  final int? id;
  const LinkFormPage({
    super.key,
    this.id,
    required String model,
  });
  @override
  State<LinkFormPage> createState() => _LinkFormPageState();
}

class _LinkFormPageState extends State<LinkFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController modelidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // isEdit = true;
      // fetchTodo(widget.id as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: Text(
          (widget.id != null) ? 'Edit ' : 'Add Link',
        ),
        actions: const <Widget>[CustomAppBar()],
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: titleController,
                  cursorColor: const Color.fromARGB(255, 97, 8, 119),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    hintText: 'title',
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: slugController,
                  cursorColor: const Color.fromARGB(255, 97, 8, 119),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 97, 8, 119),
                    )),
                    hintText: 'Url',
                    prefixIcon: Icon(
                      Icons.add_link_sharp,
                      color: Color.fromARGB(255, 97, 8, 119),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                  ),
                  onPressed: submitData,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      (widget.id != null) ? 'Update' : 'Create',
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> fetchTodo(int id) async {
    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      // const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      var url = AppConfig.linkurl;
      // print(url);

      // print(AppConfig.requestHeaders);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        titleController.text = result['message']['record']['urls']['title'];
        slugController.text = result['message']['record']['urls']['slug'];
        modelidController.text = result['message']['model type'];
        idController.text = result['message'][' model id'];
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

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {}
    final title = titleController.text;
    final slug = slugController.text;

    final body = {
      "name": title,
      "url": slug,
    };

    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      // var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/urls';

      var url = widget.id != null
          ? '${AppConfig.baseUrl}/${widget.id}/'
          : AppConfig.baseUrl;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));
      final result = jsonDecode(response.body);
      // print(result);
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          titleController.text = '';
          slugController.text = '';
        }

        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          message:
              "Notes ${widget.id != null ? 'updated' : 'added'} successfully.",
          bgColor: const Color.fromARGB(255, 97, 8, 119),
        );
      } else {
        throw (result['message']);
      }
    } catch (e) {
      CustomSnackBar.show(context, message: '$e', bgColor: Colors.red);
    }
  }
}
