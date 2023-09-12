import 'package:flutter/material.dart';

class FileManager extends StatelessWidget {
  const FileManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
        title: const Text("File Manager"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          children: [
            searchBox(),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 242),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefix: Icon(
            Icons.search,
            size: 25,
            color: Color.fromARGB(255, 97, 8, 119),
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 22,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search File",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
