import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Information")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _imageFile == null
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
            const SizedBox(height: 5),
            IconButton(
              onPressed: _pickImage,
              icon: const Icon(Icons.edit),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
