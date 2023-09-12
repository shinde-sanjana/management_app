import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Screens/dashboard_screen.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late String _currentPassword;
  late String _newPassword;
  late String _confirmPassword;
  Future<void> changePassword() async {
    if (_currentPassword.isEmpty ||
        _newPassword.isEmpty ||
        _confirmPassword.isEmpty) {
      return;
    }

    if (_newPassword != _confirmPassword) {
      return;
    }

    final payload = {
      'currentPassword': _currentPassword,
      'newPassword': _newPassword,
      'confirmPassword': _confirmPassword,
    };

    final jsonData = jsonEncode(payload);

    final response = await http.put(
      'https://sa.myriadcara.local/api/change-password' as Uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text('Change Password'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                onChanged: (value) {
                  setState(() {
                    _currentPassword = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: const InputDecoration(labelText: 'New Password'),
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            InkWell(
              child: ElevatedButton(
                onPressed: () {
                  changePassword();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                ),
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
