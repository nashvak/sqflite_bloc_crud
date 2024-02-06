import 'package:flutter/material.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/models/models.dart';

class AddscreenAppbar extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const AddscreenAppbar({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                todoBloc.add(LoadTodoEvent());
              },
              padding: const EdgeInsets.all(0),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final todo = Todo(
                    title: titleController.text,
                    description: descriptionController.text);
                print(todo.title);
                todoBloc.add(AddTodoEvent(todo: todo));
                Navigator.pop(context);
              },
              padding: const EdgeInsets.all(0),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
