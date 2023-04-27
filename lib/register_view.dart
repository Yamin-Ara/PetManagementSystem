import 'package:flutter/material.dart';
import 'package:pet_management/routes.dart';
import 'package:pet_management/util/dropdown.dart';

const List<String> list = <String>['User', 'Vet', 'Admin'];

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  String selectedValue = '';

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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonExample(onChanged: (String value) {
                    setState(() {
                      selectedValue = value;
                      if (selectedValue == 'vet') {
                        selectedValue = 'ok';
                      }
                    });
                  }),
                  const SizedBox(height: 20),
                  Text('Selected Value: $selectedValue'),
                ],
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
