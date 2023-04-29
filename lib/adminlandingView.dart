import 'package:flutter/material.dart';
import 'package:pet_management/adminnav/adminArchivePosts.dart';
import 'package:pet_management/adminnav/emergencyView.dart';
import 'package:pet_management/adminnav/urgentPosts.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/util/menu_actions.dart';

class adminLandingView extends StatefulWidget {
  const adminLandingView({super.key});

  @override
  State<adminLandingView> createState() => _adminLandingViewState();
}

class _adminLandingViewState extends State<adminLandingView> {
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
            icon: Icon(Icons.archive_outlined),
            label: 'Archive',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: 'Urgent',
            backgroundColor: Color.fromARGB(253, 62, 33, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_outlined),
            label: 'Emergency Alert',
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
    AdminArchiveView(),
    UrgentView(),
    EmergencyView(),
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
