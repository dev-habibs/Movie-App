import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_mad_project/models/user_model.dart';
import 'package:final_mad_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget _titleText() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: RichText(
          text: TextSpan(
            text: 'Sign up',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 58),
            children: <TextSpan>[
              TextSpan(
                  text: '.', style: TextStyle(color: Colors.pink.shade300)),
            ],
          ),
        ),
      );
    }

    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            // color: Colors.pink,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
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
        controller: passwordEditingController,
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
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ));

    //signup button
    final signUpButton = Row(children: [
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
              onPressed: () {
                signUp(emailEditingController.text,
                    passwordEditingController.text);
              },
              child: const Text('Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
    ]);

    Widget _loginScreen(BuildContext context) {
      return InkWell(
        onTap: (() {
          Navigator.pop(context);
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    Widget _backButton(BuildContext context) {
      return Positioned(
        // top: 400,
        // left: 0,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  child: Icon(Icons.keyboard_arrow_left,
                      color: Colors.grey.shade50),
                ),
                Text('Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade50))
              ],
            ),
          ),
        ),
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
                 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 28.0, right: 50),
                      child: _backButton(context),
                    ),
                   
                    _titleText(),
                    SizedBox(height: 35),
                    firstNameField,

                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 35),
                    signUpButton,
                    SizedBox(height: 15),
                    _loginScreen(context),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetialsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetialsToFirestore() async {
    //call firestore creating user model send the value
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;
    userModel.email = user.email;

    userModel.name = nameEditingController.text;
    await firebaseFirestore
        .collection('user')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Succesffully");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
