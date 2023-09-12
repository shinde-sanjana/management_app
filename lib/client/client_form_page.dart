// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ssm_app/config.dart';

import '../custom_appbar.dart';
import '../custom_snackbar.dart';

class ClientFormPage extends StatefulWidget {
  final int? id;
  const ClientFormPage({
    super.key,
    this.id,
  });

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aliasController = TextEditingController();
  TextEditingController contactnumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // bool isEdit = false;
  bool autoValidate = true;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // isEdit = true;
      fetchTodo(widget.id as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: Text(
          (widget.id != null) ? 'Edit ' : 'Add Client',
        ),
        actions: const <Widget>[CustomAppBar()],
      ),
      body: Center(
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Name can't be empty";
                  } else {
                    return "Invalid Email";
                  }
                },
                controller: nameController,
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
                  hintText: 'Client Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                // validator: MultiValidator([
                //   RequiredValidator(errorText: 'Required'),
                //   EmailValidator(errorText: 'Please enter client\'s full name')
                // ]),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Alias can't be empty";
                  } else {
                    return "Invalid Alias";
                  }
                },
                controller: aliasController,
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
                  hintText: 'Alias',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 5,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Contact number is required";
                  } else {
                    return "Invalid Contact";
                  }
                },
                controller: contactnumberController,
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
                  hintText: 'contact number',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 5,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "email address is required";
                  } else {
                    return "Invalid Email";
                  }
                },
                controller: emailController,
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
                  hintText: 'email address',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // minLines: 5,
                // maxLines: 5,
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
          ),
        ),
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
      var url = '${AppConfig.clients}/$id';
      // print(AppConfig.requestHeaders);
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.requestHeaders,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map;
        nameController.text = result['message']['record']['name'];
        aliasController.text = result['message']['record']['alias'];
        contactnumberController.text =
            result['message']['record']['contact number'];
        emailController.text = result['message']['record']['email'];
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
    final name = nameController.text;
    final alias = aliasController.text;

    final body = {
      "name": name,
      "alias": alias,
    };

    // final header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    try {
      var url = widget.id != null
          ? '${AppConfig.clients}/${widget.id}'
          : AppConfig.clients;

      final response = await (widget.id != null
          ? http.put(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders)
          : http.post(Uri.parse(url),
              body: jsonEncode(body), headers: AppConfig.requestHeaders));
      final result = jsonDecode(response.body);
      // print(result);
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (widget.id == null) {
          nameController.text = '';
          aliasController.text = '';
          contactnumberController.text = '';
          emailController.text = '';
        }

        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          message:
              "Client ${widget.id != null ? 'updated' : 'added'} successfully.",
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
