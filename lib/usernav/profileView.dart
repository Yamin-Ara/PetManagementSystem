import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String username = '';
  String bio = '';
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(snap.data());
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      bio = (snap.data() as Map<String, dynamic>)['bio'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1680521094897-7b161e2b31ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=415&q=80'),
                //backgroundColor: Colors.red,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("Name: $username"),
          Text("BIO: $bio"),
          Text("About Me: I own a cat"),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  adminArchiveViewRoute, (route) => false);
            },
            child: Text("Go to Admin View"),
          )
        ],
      ),
    );
  }
}
