import 'package:flutter/material.dart';
import 'package:ssm_app/password/setup_password.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
            child: Text(
              "Security",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 97, 8, 119), fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text("SetUp 6 digit pin"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PinUnlockPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            child: Text("App",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Color.fromARGB(255, 97, 8, 119), fontSize: 25)),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text("Themes"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ThemePage(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
