import 'package:flutter/material.dart';

import 'New_task_page.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("Task"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            searchBox(),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 97, 8, 119),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewTask()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 242, 242),
          borderRadius: BorderRadius.circular(20)),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 97, 8, 119),
            size: 25,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search Task",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
