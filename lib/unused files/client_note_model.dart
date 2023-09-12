class ClientNote {
  final String name;
  final String alias;
  final String address;
  final String geolocation;
  final String description;
  final int phone;
  final String email;
  final String status;

  final String jiraproject;

  const ClientNote({
    required this.name,
    required this.alias,
    required this.address,
    required this.geolocation,
    required this.description,
    required this.phone,
    required this.email,
    required this.status,
    required this.jiraproject,
  });

  factory ClientNote.fromJson(Map<String, dynamic> json) => ClientNote(
        name: json['name'],
        alias: json['alias'],
        address: json['address'],
        geolocation: json['geolocation'],
        description: json['description'],
        phone: json['phone'],
        email: json['email'],
        status: json['status'],
        jiraproject: json['jiraproject'],
      );

  get id => null;

  Map<String, dynamic> toJson() => {
        'name': name,
        'alias': alias,
        'address': address,
        'geolocation': geolocation,
        'description': description,
        'phone': phone,
        'email': email,
        'status': status,
        'jiraproject': jiraproject,
      };
}
