import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app_bloc/models/models.dart';

import 'package:todo_app_bloc/screen/widgets/addscreen_appbar.dart';

import '../bloc/todo_bloc.dart';

class AddScreen extends StatefulWidget {
  AddScreen({
    super.key,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  File? image;

  XFile? pickedFile;

  getImage(bool isCamera) async {
    final picker = ImagePicker();
    if (isCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
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
                  onPressed: () async {
                    final bytes = await image!.readAsBytes();
                    final todo = Todo(
                      imageBytes: bytes,
                      title: titleController.text,
                      description: contentController.text,
                    );
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
            ),
            Expanded(
                child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black)),
                      child: image == null
                          ? Center(child: Text('No photos yet..'))
                          : Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              getImage(true);
                            },
                            icon: Icon(Icons.camera_alt),
                            label: Text('Take Photo')),
                        TextButton.icon(
                            onPressed: () {
                              getImage(false);
                            },
                            icon: Icon(Icons.photo),
                            label: Text('Select from gallery')),
                      ],
                    )
                  ],
                ),
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
