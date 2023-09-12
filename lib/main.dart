import 'package:flutter/material.dart';
import 'package:ssm_app/config.dart';

import 'splash_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.getInstance().then((pref) {
  //   var themeColor = pref.getString('ThemeMode');
  //   if (themeColor == "Dark") {
  //     var activeTheme = dartTheme;
  //   } else if (themeColor == "Light") {
  //     var activeTheme = lightTheme;
  //   } else if (themeColor == "Purple") {
  //     var activeTheme = purpleTheme;
  //   } else if (themeColor == "Blue") {
  //     var activeTheme = blueTheme;
  //   }
  // });
  // var activeTheme;
  runApp(
      // MultiProvider(providers: [
      //   ChangeNotifierProvider(create: (context) => ThemeNotifier(activeTheme)),
      // ], child: const MyApp()),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var activeTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSM App',
      // theme: activeTheme,
      theme: AppConfig.iconbool ? AppConfig.darktheme : AppConfig.lighttheme,
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primarySwatch: Colors.blue,
      // // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      // ),
      home: const SplashScreen(),
    );
  }
}
