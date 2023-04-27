import 'package:flutter/material.dart';
import 'package:pet_management/nav/createNewView.dart';
import 'package:pet_management/nav/homeView.dart';
import 'package:pet_management/nav/profileView.dart';
import 'package:pet_management/nav/searchView.dart';

class landingView extends StatefulWidget {
  const landingView({super.key});

  @override
  State<landingView> createState() => _landingViewState();
}

class _landingViewState extends State<landingView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petsgram'),
        backgroundColor: const Color.fromARGB(253, 62, 33, 76),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Post',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'My Profile',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: _pageList.elementAt(_selectedIndex),
    );
  }

//
//

  static const List<Widget> _pageList = <Widget>[
    HomeView(),
    SearchView(),
    CreateNewView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
