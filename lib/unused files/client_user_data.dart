class Client {
  final int id;
  final String name;
  final String alias;
  final String email;
  final String phoneNumber;

  Client({
    required this.id,
    required this.name,
    required this.alias,
    required this.email,
    required this.phoneNumber,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      alias: json['alias'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Object? toMap() {}
}
