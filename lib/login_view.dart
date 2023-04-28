import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/util/dropdown.dart';

const List<String> list = <String>['User', 'Vet', 'Admin'];
final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String selectedValue = '';
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

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
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            TextFormField(
              controller: _password,
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
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      landingRoute,
                      (route) => false,
                    );
                  } catch (e) {}
                  ;
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
