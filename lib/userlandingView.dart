import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/usernav/createNewPostView.dart';
import 'package:pet_management/usernav/homeView.dart';
import 'package:pet_management/usernav/profileView.dart';
import 'package:pet_management/usernav/searchView.dart';
import 'package:pet_management/util/menu_actions.dart';

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
        actions: [
          PopupMenuButton<menuAction>(
            onSelected: (value) async {
              switch (value) {
                case menuAction.logout:
                  final doLogout = await showLogOutDialog(context);

                  if (doLogout) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<menuAction>(
                  value: menuAction.logout,
                  child: Text('logout'),
                ),
              ];
            },
          ),
        ],
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

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out ?'),
        content: const Text('Sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
