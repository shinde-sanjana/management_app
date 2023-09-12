import 'package:flutter/material.dart';

class NewActivity extends StatelessWidget {
  const NewActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Activity"),
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
      ),
      body: const ActivityForm(),
    );
  }
}

class ActivityForm extends StatefulWidget {
  const ActivityForm({super.key});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  icon: Icon(
                    Icons.file_copy,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  hintText: "Enter Task ID",
                  labelText: "task Id",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "DD/MM/YY",
                  labelText: "Start Date",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "DD/MM/YY",
                  labelText: "Due Date",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.lock_clock,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "Duration",
                  labelText: "Duration",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.task,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "Stages",
                  labelText: "Stages",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 97, 8, 119),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description_rounded,
                    color: Color.fromARGB(255, 97, 8, 119),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 97, 8, 119),
                  )),
                  hintText: "Enter Description",
                  labelText: "Add Description",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 97, 8, 119))),
            ),
            Row(
              children: [
                Container(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text("Create"),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text("Delete"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
