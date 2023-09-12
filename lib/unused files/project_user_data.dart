class Project {
  int id;
  final String clientname;
  final String projectname;
  final String projectdesc;
  DateTime startdate;
  DateTime enddate;
  List<String> stages;

  Project({
        required this.id,

    required this.clientname,
    required this.projectname,
    required this.projectdesc,
    required this.startdate,
    required this.enddate,
    required this.stages,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
        clientname: json['clientname'],
        projectname: json['projectname'],
        projectdesc: json['projectdesc'],
        startdate: json['startdate'],
        enddate: json['enddate'],
        stages: json['stages']);
  }

  Map<String, dynamic> toJson() {
    return {
      'clientname': clientname,
      'projectname': projectname,
      'projectdesc': projectdesc,
      'startdate': startdate,
      'enddate': enddate,
      'stages': stages,
    };
  }
}
