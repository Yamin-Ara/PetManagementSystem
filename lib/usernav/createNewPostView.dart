import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_management/providers/user_provider.dart';
import 'package:pet_management/services/firestore_methods.dart';
import 'package:pet_management/util/dropdown2.dart';
import 'package:pet_management/util/utils.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Urgent', 'Not urgent'];

class CreateNewView extends StatefulWidget {
  const CreateNewView({super.key});

  @override
  State<CreateNewView> createState() => _CreateNewViewState();
}

class _CreateNewViewState extends State<CreateNewView> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool urgent = false;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                  padding: const EdgeInsets.all(25),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text("Take a photo")),
              SimpleDialogOption(
                padding: const EdgeInsets.all(25),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                child: Text("Choose from gallery"),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(25),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void postImage(String uid, String username) async {
    // start the loading
    try {
      // upload to storage and db
      await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        urgent,
      );
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: clearImage,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("New Post"),
          actions: [
            TextButton(
              onPressed: () {
                postImage(
                  userProvider.getUser.uid,
                  userProvider.getUser.username,
                );
                if (selectedValue == 'To Admins') {
                  const snackBar = SnackBar(content: Text('Sent to Admins!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(content: Text('Posted to feed!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ]),
      body: Column(
        children: [
          TextFormField(
            controller: _descriptionController,
            decoration:
                const InputDecoration(hintText: "What's on your mind? "),
          ),
          SizedBox(
            height: 20.0,
          ),
          DropdownButtonExample2(onChanged: (String value) {
            setState(() {
              selectedValue = value;
              if (selectedValue == 'Urgent') {
                urgent = true;
                selectedValue = 'To Admins';
              }
            });
          }),
          const SizedBox(height: 20),
          Text('Selected Value: $selectedValue'),
          SizedBox(
            height: 20.0,
          ),
          Text("Upload Image"),
          _file == null
              ? Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.image_outlined,
                    ),
                    onPressed: () => _selectImage(context),
                  ),
                )
              : SizedBox(
                  height: 250.0,
                  width: 250.0,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(_file!),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
