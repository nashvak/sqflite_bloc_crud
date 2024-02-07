import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app_bloc/models/models.dart';

import 'package:todo_app_bloc/screen/widgets/addscreen_appbar.dart';

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
    // final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AddscreenAppbar(
              titleController: titleController,
              descriptionController: contentController,
              imageFile: image!,
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
