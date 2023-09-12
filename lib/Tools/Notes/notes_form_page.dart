import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssm_app/custom_snackbar.dart';

import '../../config.dart';
import '../../custom_appbar.dart';

class NotesFormPage extends StatefulWidget {
  final int? id;
  final String model;
  const NotesFormPage({
    super.key,
    this.id,
    required this.model,
  });
  @override
  State<NotesFormPage> createState() => _NotesFormPageState();
}

class _NotesFormPageState extends State<NotesFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
          (widget.id != null) ? 'Edit ' : 'Add Notes',
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
                  controller: descriptionController,
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
                    hintText: 'Description',
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

  Future<void> fetchTodo(
    int id,
  ) async {
    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      // const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      var url = AppConfig.notes;

      // print(AppConfig.requestHeaders);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        titleController.text = result['message']['record']['notes']['title'];
        descriptionController.text =
            result['message']['record']['notes']['description'];
        modelidController.text = result['message']['model_type'];
        idController.text = result['message'][' model_id'];
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
    final description = descriptionController.text;

    final body = {
      "name": title,
      "description": description,
    };

    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      var url = '${AppConfig.baseUrl}${widget.model}/${widget.id}/urls';

      // var url = widget.id != null
      //     ? '${AppConfig.notes}/${widget.id}'
      //     : AppConfig.notes;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));
      final result = jsonDecode(response.body);
      print(result);
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          titleController.text = '';
          descriptionController.text = '';
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
