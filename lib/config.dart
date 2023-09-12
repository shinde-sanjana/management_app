import 'package:flutter/material.dart';

class AppConfig {
  static ThemeData lighttheme =
      ThemeData(primarySwatch: Colors.purple, brightness: Brightness.light);
  static ThemeData darktheme =
      ThemeData(primarySwatch: Colors.green, brightness: Brightness.dark);
  static bool iconbool = false;

  static const String username = 'SSM App';
  static const String baseUrl = "http://sa.myc.local/api/";
  // static const String baseUrl = "http://test2.myriadcara.in/api/";
  static const String login = "${baseUrl}login";
  static const String forgetpassword = "baseUrl + forgot-password"; static const String changepassword = "baseUrl + change-password"; static const String profile = "${baseUrl}get-profile"; static const String updateprofile = "${baseUrl}update-profile";

  static const String clients = "${baseUrl}clients";
  static const String projects = "${baseUrl}projects";
  static const String tasks = "${baseUrl}tasks";
  static const String activity = "${baseUrl}activity";
  static String model = "";
  static String modelid = "";
  static String linkurl = "$baseUrl$model/$modelid/urls";
  static String notes = "$baseUrl$model/$modelid/notes";
  static String files = "$baseUrl$model/$modelid/files";

  static const bool offline = false;
  static String token = "";

  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer $token",
  };
}
