import 'package:flutter/material.dart';
import 'package:ssm_app/Screens/verification_code_screen.dart';

import '../login/login_screen.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool passToggle = true;
  void _sendPasswordResetEmail(String email) async {
    const url = 'http://sa.myriadcara.local/api/forgot-password';
    final response = await http.post(
      Uri.parse(url),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
        ),
      );
    } else {
      const errorMessage =
          'Failed to send password reset email. Please try again.';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(errorMessage)),
      );
    }
  }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      //   title: const Text(
      //     'Forget Password',
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                    "assets/images/logo_for_letterhead-removebg-preview.png")),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
              child: Align(
                alignment: FractionalOffset.center,
                child: Container(
                  color: const Color.fromARGB(255, 97, 8, 119),
                  height: 400,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Forget password?',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          cursorColor: const Color.fromARGB(255, 97, 8, 119),
                          cursorHeight: 20.6,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 5),
                              prefix: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: 'Email',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 97, 8, 119),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 97, 8, 119),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerificationScreen()));
                                  String email = _emailController.text;
                                  _sendPasswordResetEmail(email);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 97, 8, 119),
                                  ),
                                )),
                            const SizedBox(width: 36),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FormScreen()));
                                  String email = _emailController.text;
                                  _sendPasswordResetEmail(email);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 97, 8, 119),
                                  ),
                                )),
                          ],
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

  //void _sendPasswordResetEmail(String email) {
  // Implement the logic to send the password reset email
  // You can integrate with your backend API or use Firebase or any other authentication service
  // Here, you can display a success message or show an error if the email is not valid, etc.
}
//}
