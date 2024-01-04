import 'package:flutter/material.dart';

class AddscreenAppbar extends StatelessWidget {
  const AddscreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            //context.go('/home');
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
            // saveButton(context);
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
  }
}
