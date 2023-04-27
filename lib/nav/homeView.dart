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
      body: const PostCard(),
    );
  }
}
