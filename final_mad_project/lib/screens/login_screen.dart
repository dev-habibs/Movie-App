// import 'dart:js';

import 'package:final_mad_project/resetpass_screen.dart';
import 'package:final_mad_project/screens/home_screen.dart';
import 'package:final_mad_project/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    ThemeData(brightness: Brightness.dark);
    Widget _titleText() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: RichText(
          text: TextSpan(
            text: 'Sign in',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 58),
            children: <TextSpan>[
              TextSpan(
                  text: '.',
                  style: TextStyle(color: Color.fromARGB(255, 214, 30, 168))),
            ],
          ),
        ),
      );
    }

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // fillColor: Colors.grey[900],
          // filled: true,
          // contentPadding: const EdgeInsets.all(19),
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade800,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          // fillColor: Colors.grey[900],
          // filled: true,
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade800,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 1.0],
              colors: [
                Colors.purple,
                Colors.pink.shade300,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
              onPressed: () {
                signIn(emailController.text, passwordController.text);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent,
                ),
              ),
              child: const Text('Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
    ]);

    _divider() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Text(
              'or',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      );
    }

    _socialLogins() {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                border: Border.all(color: Colors.grey.shade800),
                borderRadius: const BorderRadius.all(Radius.circular(
                        12.0) //                 <--- border radius here
                    ),
              ),
              child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 40,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                border: Border.all(color: Colors.grey.shade800),
                borderRadius: const BorderRadius.all(Radius.circular(
                        12.0) //                 <--- border radius here
                    ),
              ),
              child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.apple,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _titleText(),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    Center(child: loginButton),
                    // SizedBox(height: 15),
                    _divider(),
                    // SizedBox(height: 10),
                    _socialLogins(),
                    SizedBox(height: 10),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
