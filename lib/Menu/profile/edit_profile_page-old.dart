// import 'package:flutter/material.dart';
// import 'package:ssm_app/Menu/profile/profile_screen.dart';
// import 'package:ssm_app/config.dart';
// import 'package:http/http.dart' as http;

// import '../../login/login_screen.dart';

// class EditProfile extends StatelessWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();

// }

// class _EditProfileState extends State<EditProfile> {
//   final _formfield = GlobalKey<EditProfile>();
//   // final emailController = TextEditingController();
//   // final passController = TextEditingController();
//   bool passToggle = true;
//   // late SharedPreferences logindata;
//   // late bool newuser;
//   @override
  // void initState() {
  //   print(AppConfig.token);
  //   super.initState();
  //   // check_if_already_login();
  // }

//   Future<void> UpdateProfile() async {
//     // print(AppConfig.login);
//     final response = await http.post(Uri.parse(AppConfig.login), body: {
//       'email': 'emailController.text',
//       'password': 'passController.text',
//     });

//     if (response.statusCode == 200) {
//       // AppConfig.token = jsonDecode(response.body)['data']['token'];
//       // ignore: use_build_context_synchronously
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => const HomeScreen()),
//       // );
//     } else {
//       // print(response);
//       const errorMessage = 'Login failed. Please try again.';
//       // ignore: use_build_context_synchronously
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text(errorMessage)),
//       // );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 97, 8, 119),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Align(
//                 alignment: Alignment.center,
//                 child: Image.network(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9g1ihD3e3aKZ-E78bD7gILiEMXM2CaEUKeg&usqp=CAU",
//                   height: 90,
//                   width: 90,
//                   //color: Color.fromARGB(255, 97, 8, 119),
//                 )),
//             const SizedBox(height: 15),
//             TextFormField(
//               cursorColor: const Color.fromARGB(255, 97, 8, 119),
//               decoration: const InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//                   icon: Icon(
//                     Icons.person,
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   ),
//                   hintText: 'Enter Full name',
//                   labelText: 'Name',
//                   labelStyle: TextStyle(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please enter full name";
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: const Color.fromARGB(255, 97, 8, 119),
//               decoration: const InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//                   icon: Icon(
//                     Icons.email,
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   ),
//                   hintText: 'Enter Email Address',
//                   labelText: 'Email',
//                   labelStyle: TextStyle(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please enter email address";
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: const Color.fromARGB(255, 97, 8, 119),
//               decoration: const InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//                   icon: Icon(
//                     Icons.contact_page,
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   ),
//                   hintText: 'Enter Contact Number',
//                   labelText: 'Contact Number',
//                   labelStyle: TextStyle(
//                     color: Color.fromARGB(255, 97, 8, 119),
//                   )),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please enter contact number";
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ProfileScreen()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 97, 8, 119),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 8.0),
//                 ),
//                 child: const Text('Save'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const EditProfile()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 97, 8, 119),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 8.0),
//                 ),
//                 child: const Text('Cancel'),
//               ),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }
