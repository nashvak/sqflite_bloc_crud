import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../models/models.dart';

class UpdateScreen extends StatefulWidget {
  final Todo todo;
  const UpdateScreen({super.key, required this.todo});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController =
        TextEditingController(text: widget.todo.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              Row(
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
                      // final todo = Todo(
                      //     title: titleController.text,
                      //     description: descriptionController.text,
                      //     imageBytes: );
                      // print(todo.title);
                      // print(todo.description);
                      // todoBloc.add(UpdateButtonClickedEvent(todo: todo));
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
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    // cursorColor: style.color,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
      ),
    );
  }
}
