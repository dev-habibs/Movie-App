import 'package:final_mad_project/screens/home_screen.dart';
import 'package:final_mad_project/screens/login_screen.dart';
import 'package:final_mad_project/screens/secondary_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter',
      home: const LoginScreen(),
      theme: ThemeData(
          fontFamily: "Open-Sans",
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xff121212)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
