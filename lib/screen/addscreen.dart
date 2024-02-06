import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_app_bloc/screen/widgets/addscreen_appbar.dart';

import '../bloc/todo_bloc.dart';

class AddScreen extends StatelessWidget {
  AddScreen({
    super.key,
  });
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AddscreenAppbar(
              titleController: titleController,
              descriptionController: contentController,
            ),
            Expanded(
                child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  // cursorColor: style.color,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 30),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 30),
                  ),
                ),
                TextFormField(
                  controller: contentController,
                  // cursorColor: style.color,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 17),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
