import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/services/auth_methods.dart';
import 'package:pet_management/util/dropdown.dart';
import 'package:pet_management/models/user.dart' as model;

const List<String> list = <String>['User', 'Vet', 'Admin'];
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  String selectedValue = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    // signup user using our authmethodds
    await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: selectedValue,
    );
    // if string returned is sucess, user has been created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Petsgram Registration'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(253, 62, 33, 76),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            aboutSection,
            const SizedBox(
              height: 2.0,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            TextFormField(
              controller: _passwordController,
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

                      if (selectedValue == 'vet') {
                        selectedValue = 'doc';
                      }
                    });
                  }),
                  const SizedBox(height: 20),
                  Text('Selected Value: $selectedValue'),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  signUpUser;
                  final email = _emailController.text;
                  final pass = _passwordController.text;
                  final uname = _usernameController.text;
                  UserCredential cred =
                      await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: pass,
                  );
                  model.User _user = model.User(
                    username: uname,
                    uid: cred.user!.uid,
                    //photoUrl: photoUrl,
                    email: email,
                    bio: selectedValue,
                    //followers: [],
                    //following: [],
                  );
                  await _firestore
                      .collection("users")
                      .doc(cred.user!.uid)
                      .set(_user.toJson());

                  const snackBar = SnackBar(content: Text('Sign up complete!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: const Color.fromARGB(238, 46, 59, 65),
              ),
              child: const Text('Not a new User? Login here'),
            ),
          ],
        ),
      ),
    );
  }

  Widget aboutSection = Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'About Us:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            'The place for all animal lovers',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 2.0,
              color: Colors.blueGrey.shade900,
            ),
          ),
          const SizedBox(height: 2.0),
        ],
      ));
}
