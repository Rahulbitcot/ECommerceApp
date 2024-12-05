import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImaged) onPickedImage;

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? pickedImagedFile;

  void _pickImage() async {
    final pickedImaged = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 100,
        maxWidth: 100);

    if (pickedImaged == null) {
      return;
    }
    setState(() {
      pickedImagedFile = File(pickedImaged.path);
    });

    widget.onPickedImage(pickedImagedFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              pickedImagedFile != null ? FileImage(pickedImagedFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
