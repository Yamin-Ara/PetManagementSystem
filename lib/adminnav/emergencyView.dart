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
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Text("Rescue Team"),
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
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text("Volunteers Association"),
              IconButton(
                onPressed: () {
                  // ignore: deprecated_member_use
                  launch("tel:999");
                },
                icon: Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {
                  notificationService.sendNotifications("Rescue needed!!!");
                },
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text("Ambulence"),
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
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text("NGO"),
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
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text("Adoption Agency"),
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
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text("Vets"),
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
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
