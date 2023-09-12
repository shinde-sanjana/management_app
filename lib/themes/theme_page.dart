// import 'package:flutter/material.dart';
// import 'package:group_radio_button/group_radio_button.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ssm_app/themes/color.dart';
// import 'package:ssm_app/themes/themenotifier.dart';
// import 'package:ssm_app/themes/themenotifier.dart';

// class ThemePage extends StatefulWidget {
//   const ThemePage({super.key});

//   @override
//   State<ThemePage> createState() => _ThemePageState();
// }

// class _ThemePageState extends State<ThemePage> {
//   String _selectedColor = "Blue";

//   List<String> _colors = ["Dark", "Light", "purple", "Blue"];

//   void onThemeChange(String value, ThemeNotifier themeNotifier) async {
//     if (value == "dark") {
//       themeNotifier = themeNotifier.setTheme(dartTheme);
//     } else if (value == "light") {
//       themeNotifier = themeNotifier.setTheme(lightTheme);
//     } else if (value == "purple") {
//       themeNotifier = themeNotifier.setTheme(purpleTheme);
//     } else if (value == "blue") {
//       themeNotifier = themeNotifier.setTheme(blueTheme);
//     }
//     final pref = await SharedPreferences.getInstance();
//     pref.setString("ThemeMode", value);
//   }

//   @override
//   Widget build(BuildContext context) {
//       ThemeNotifier = Provider.of<ThemeNotifier>(context);
//     ThemeNotifier.getTheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("App Theme"),
//       ),
//       body: Container(
//         child: Center(
//           child: MaterialButton(
//             color: Colors.purple,
//             onPressed: () {
//               themeChangeDialog(ThemeNotifier);
//             },
//             child: const Text(
//               "Change Theme",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   themeChangeDialog(ThemeNotifier themeNotifier) {
//     showDialog(
//         context: context,
//         builder: (_) => StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//               return AlertDialog(
//                   content: SizedBox(
//                     height: 250,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         RadioGroup<String>.builder(
//                             groupValue: _selectedColor,
//                             onChanged: (val) {
//                               setState(() {
//                                 _selectedColor = val!;
//                               });
//                               onThemeChange(_selectedColor, themeNotifier);
//                               print(_selectedColor);
//                             },
//                             items: _colors,
//                             itemBuilder: (item) => RadioButtonBuilder(item)),
//                       ],
//                     ),
//                   ),
//                   actions: <Widget>[
//                     MaterialButton(
//                         child: const Text("close"),
//                         onPressed: () {
//                           Navigator.of(context).pop(true);
//                         })
//                   ]);
//             }));
//   }
// }
