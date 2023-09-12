import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import '../password/forget_password_screen.dart';
import '../config.dart';

// String stringResponse;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  // var EmailValidator;

  // void _submitForm() {
  //   if (_formfield.currentState!.validate()) {
  //     String email = emailController.text;
  //     String password = passController.text;
  //   }
  // }
  // Future apicall() async {
  //   http.Response response;
  //   response = await http.post(Uri.parse(AppConfig.login));
  //   if (response.statusCode == 200) ;
  //   setState(() {
  //     var stringResponse = response.body;
  //   });
  // }

  Future<void> loginUser() async {
    // print(AppConfig.login);
    final response = await http.post(Uri.parse(AppConfig.login),
        // headers: AppConfig.requestHeaders,
        body: {
          'email': emailController.text,
          'password': passController.text,
        });

    if (response.statusCode == 200) {
      AppConfig.token = jsonDecode(response.body)['data']['token'];
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // print(response);
      const errorMessage = 'Login failed. Please try again.';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo_for_letterhead-removebg-preview.png",
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
              child: Align(
                alignment: FractionalOffset.center,
                child: Container(
                  color: const Color.fromARGB(255, 97, 8, 119),
                  height: 400,
                  width: 400,
                  child: Form(
                    key: _formfield,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 350,
                          child: TextFormField(
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // validator: ((value) {
                            //   if (value!.isEmpty) {
                            //     return 'please enter your email';
                            //   }
                            //   return null;
                            // }),
                            cursorColor: const Color.fromARGB(255, 97, 8, 119),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            enableSuggestions: true,
                            decoration: const InputDecoration(
                              iconColor: Color.fromARGB(255, 97, 8, 119),
                              hintText: "Email",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 97, 8, 119),
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "email is required";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            cursorColor: const Color.fromARGB(255, 97, 8, 119),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please enter your password';
                            //   } else if (passController.text.length < 8) {
                            //     return 'minimum 8 characters';
                            //   }
                            // },
                            decoration: const InputDecoration(
                              hintText: "Password",
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 97, 8, 119),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 97, 8, 119),
                              ),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "email is required"),
                              MinLengthValidator(8,
                                  errorText: "atleast 8 character required")
                            ]),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 206, 205, 205),
                          ),
                          onPressed: () {
                            String email = emailController.text;
                            String password = passController.text;
                            if (email != '' && password != '') {
                              if (kDebugMode) {
                                print("Successfull");
                              }
                              logindata.setBool('login', false);

                              logindata.setString('email', email);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              loginUser();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const HomeScreen()));
                            },
                            child: Container(
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 206, 205, 205),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "login",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 8, 119),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        GestureDetector(
                          child: const Text(
                            " Forgot Password?",
                            style: TextStyle(
                                color: Colors.white,
                                height: 3,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    // print("login Screen init");
    emailController.text = "emailController";
    passController.text = "passController";
    loginUser();
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login") ?? true);

    // print(newuser);
    if (newuser = false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
