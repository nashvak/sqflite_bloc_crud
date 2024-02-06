import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_bloc/screen/addscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.database});
  final Future<Database> database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('title'),
              subtitle: Text('descroption'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
