class Tasks {
  int id;
  final String clientname;
  final String projectname;
  final String taskdesc;
  final String taskname;

  DateTime startdate;
  DateTime enddate;
  List<String> stages;

  Tasks({
    required this.id,
    required this.clientname,
    required this.projectname,
    required this.taskname,
    required this.taskdesc,
    required this.startdate,
    required this.enddate,
    required this.stages,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
        id: json['id'],
        clientname: json['clientname'],
        projectname: json['projectname'],
        taskname: json['taskname'],
        taskdesc: json['taskdesc'],
        startdate: json['startdate'],
        enddate: json['enddate'],
        stages: json['stages']);
  }

  Map<String, dynamic> toJson() {
    return {
      'clientname': clientname,
      'projectname': projectname,
      'taskname': taskname,
      'taskdesc': taskdesc,
      'startdate': startdate,
      'enddate': enddate,
      'stages': stages,
    };
  }
}
