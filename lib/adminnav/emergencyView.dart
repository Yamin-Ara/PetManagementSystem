import 'package:flutter/material.dart';
import 'package:pet_management/util/notifications_service.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  final notificationService = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationService.initialiseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.red),
              title: Text("Rescue Team"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel:999");
                    },
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      notificationService.sendNotifications("Emergency!!!");
                    },
                    icon:
                        Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text("Volunteers Association"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel:999");
                    },
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      notificationService.sendNotifications("Rescue needed!!!");
                    },
                    icon:
                        Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.red),
              title: Text("Ambulance"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel:999");
                    },
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      notificationService.sendNotifications("Emergency!!!");
                    },
                    icon:
                        Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text("NGO"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel:999");
                    },
                    icon: Icon(Icons.call),
                  ),
                  IconButton(
                    onPressed: () {
                      notificationService.sendNotifications("Emergency!!!");
                    },
                    icon:
                        Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(
                Icons.pets,
              ),
              title: Text("Adoption Agency"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel:999");
                    },
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      notificationService.sendNotifications("Emergency!!!");
                    },
                    icon:
                        Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
