import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/util/postcard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.messenger_outline_sharp)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('isArchived', isEqualTo: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
