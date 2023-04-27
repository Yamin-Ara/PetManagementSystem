import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateNewView extends StatefulWidget {
  const CreateNewView({super.key});

  @override
  State<CreateNewView> createState() => _CreateNewViewState();
}

class _CreateNewViewState extends State<CreateNewView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("New Post"),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ]),
      body: Column(
        children: [
          TextFormField(
            decoration:
                const InputDecoration(hintText: "What's on your mind? "),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Upload Image"),
          Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: Icon(Icons.upload),
            ),
          ),
        ],
      ),
    );
  }
}
