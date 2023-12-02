import 'package:flutter/material.dart';

class SecondaryScreen extends StatefulWidget {
  const SecondaryScreen({super.key});

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image/movie1.jpg"),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              Color.fromARGB(255, 38, 0, 44).withOpacity(0.6),
            ], stops: [
              0.0,
              1
            ], begin: Alignment.topCenter)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 400.0,
                margin: EdgeInsets.only(top: 400.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 6, 0, 7),
                    Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
