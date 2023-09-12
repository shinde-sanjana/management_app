// import 'package:flutter/material.dart';

// class PinScreen extends StatefulWidget {
//   const PinScreen({super.key});

//   @override
//   State<PinScreen> createState() => _PinScreenState();
// }

// class _PinScreenState extends State<PinScreen> {
//   String pin = "";
//   void _onNumberClick(String text) {
//     setState(() {
//       if (pin.length < 6) {
//         pin += text;
//       }
//     });


//   void _onDeleteClick() {
//     setState(() {
//       if (pin.length > 0) {
//         pin = pin.substring(0, pin.length - 1);
//       }
//     });
//   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color.fromRGBO(117, 7, 128, 0.965),
// //         title: Text(
// //           "Enter PIN to unlock ",
// //           style: TextStyle(),
// //         ),
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             pin,
// //             style: TextStyle(fontSize: 25),
// //           ),
// //           const SizedBox(
// //             height: 20,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildNumberButton("1"),
// //               _buildNumberButton("2"),
// //               _buildNumberButton("3"),
// //             ],
// //           ),
// //           const SizedBox(
// //             height: 10,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildNumberButton("4"),
// //               _buildNumberButton("5"),
// //               _buildNumberButton("6"),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   _buildNumberButton(String s) {}
// // }
