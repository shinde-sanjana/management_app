// import 'package:flutter/material.dart';

// import '../config.dart';

// class Themes extends StatefulWidget {
//   const Themes({super.key});

//   @override
//   State<Themes> createState() => _ThemesState();
// }

// bool _iconbool = false;
// IconData _iconLight = Icons.wb_sunny;
// IconData _iconDark = Icons.nights_stay;
// ThemeData _LightTheme =
//     ThemeData(primarySwatch: Colors.purple, brightness: Brightness.light);
// ThemeData _DarkTheme =
//     ThemeData(primarySwatch: Colors.green, brightness: Brightness.dark);

// class _ThemesState extends State<Themes> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Themes",
//       // theme: _iconbool ? _DarkTheme : _LightTheme,
//       theme: AppConfig.iconbool ? AppConfig.darktheme : AppConfig.lighttheme,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Dark and light themes"),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _iconbool = !_iconbool;
//                     AppConfig.iconbool = !AppConfig.iconbool;
//                   });
//                 },
//                 icon: Icon(_iconbool ? _iconDark : _iconLight)),
//           ],
//         ),
//       ),
//     );
//   }
// }
