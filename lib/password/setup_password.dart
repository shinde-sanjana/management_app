import 'package:flutter/material.dart';

class PinUnlockPage extends StatefulWidget {
  const PinUnlockPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PinUnlockPageState createState() => _PinUnlockPageState();
}

class _PinUnlockPageState extends State<PinUnlockPage> {
  String enteredPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text('PIN Unlock Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              enteredPin,
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton('1'),
                buildNumberButton('2'),
                buildNumberButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton('4'),
                buildNumberButton('5'),
                buildNumberButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton('7'),
                buildNumberButton('8'),
                buildNumberButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton('0'),
                buildClearButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 70.0,
        height: 70.0,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              enteredPin += number;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 97, 8, 119),
            shape: const CircleBorder(),
          ),
          child: Text(number),
        ),
      ),
    );
  }

  Widget buildClearButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 70.0,
        height: 70.0,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              enteredPin = '';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 97, 8, 119),
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.backspace),
        ),
      ),
    );
  }
}
