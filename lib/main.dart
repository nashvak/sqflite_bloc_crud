import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/screen/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,description TEXT,)');
    },
    version: 1,
  );
  bool databaseExist =
      await databaseExists(join(await getDatabasesPath(), 'todo_database.db'));
  runApp(MyApp(
    database: database,
    isDatabaseExists: databaseExist,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.database, required this.isDatabaseExists});
  final Future<Database> database;
  final bool isDatabaseExists;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(database, isDatabaseExists),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo using bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(
          database: database,
        ),
      ),
    );
  }
}
