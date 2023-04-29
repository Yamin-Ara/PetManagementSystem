import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/adminlandingView.dart';
import 'package:pet_management/providers/user_provider.dart';
import 'package:pet_management/userlandingView.dart';
import 'package:pet_management/login_view.dart';
import 'package:pet_management/register_view.dart';
import 'package:pet_management/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Petsgram',
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xFF3E2154,
            <int, Color>{
              50: Color(0xFFF2E9F8),
              100: Color(0xFFE6D4F1),
              200: Color(0xFFCDA8E4),
              300: Color(0xFFB57CD7),
              400: Color(0xFF9E58CC),
              500: Color(0xFF8723BF),
              600: Color(0xFF7A1FAE),
              700: Color(0xFF6D1B9E),
              800: Color(0xFF60188D),
              900: Color(0xFF53147C),
            },
          ),
        ),
        home: const MyHomePage(title: 'Petsgram'),
        routes: {
          registerRoute: (context) => const RegistrationView(),
          loginRoute: (context) => LoginView(),
          landingRoute: (context) => const landingView(),
          adminLandingViewRoute: (context) => const adminLandingView(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
