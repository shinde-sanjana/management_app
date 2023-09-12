// class User {
//   String? userId;
//   User({
//     this.userId,
//   });

//   User.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['user_id'] = userId;
//     return data;
//   }
// }

class Contact {
  String name;
  String contact;
  String email;
  String projects;
  Contact(
      {required this.name,
      required this.contact,
      required this.email,
      required this.projects});
}
