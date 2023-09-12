// import 'package:flutter/material.dart';
// import 'package:ssm_app/Screens/home_screen.dart';

// class ChangeTheme extends StatefulWidget {
//   const ChangeTheme({super.key});

//   @override
//   State<ChangeTheme> createState() => _ChangeThemeState();
// }

// class _ChangeThemeState extends State<ChangeTheme> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Change Theme"),
//         leading: GestureDetector(
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomeScreen()));
//                 },
//                 icon: const Icon(Icons.arrow_back))),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.transparent,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.red;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Red",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.grey;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Grey",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Color.fromARGB(255, 97, 8, 119);
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Purple",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.green;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Green",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.orange;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Orange",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.pink;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Pink",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   padding: const EdgeInsets.all(10.0),
//                 ),
//                 onPressed: () {
//                   primaryColor:
//                   Colors.black;
//                   setState(() {});
//                 },
//                 child: const Text(
//                   "Black",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.all(10.0),
//                   ),
//                   onPressed: () {
//                     primaryColor:
//                     Colors.blue;
//                     setState(() {});
//                   },
//                   child: const Text(
//                     "Blue",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
