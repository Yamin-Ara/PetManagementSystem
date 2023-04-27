import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/util/dropdown.dart';

const List<String> list = <String>['User', 'Vet', 'Admin'];

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Petsgram App Login'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.amber),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonExample(onChanged: (String value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  const SizedBox(height: 20),
                  Text('Selected Value: $selectedValue'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    landingRoute,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: const Color.fromARGB(238, 46, 59, 65),
              ),
              child: const Text('New User? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
