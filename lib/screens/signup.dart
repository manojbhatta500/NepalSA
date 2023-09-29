import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepalsa/services/services.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  User? userdata;
  Services manager = Services();

  void signupdata(String email, String password) async {
    userdata = await manager.register(email, password, context);
    if (userdata != null) {
      print('successfull');
      Navigator.pushNamed(context, '/login');
    } else {
      print('something went wrong while singing up');
    }
  }

  int checkemail(String email) {
    if (email.contains('@acet')) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 0.1 * height),
              height: 0.15 * height,
              width: double.infinity,
              child: Hero(tag: 'logo', child: Image.asset('assets/logo.png'))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 0.07 * height,
            width: 0.7 * width,
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10, right: 10, top: 20, bottom: 0.1 * height),
            height: 0.07 * height,
            width: 0.7 * width,
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          InkWell(
            onTap: () {
              int checker = checkemail(email.text);
              if (checker == 1) {
                signupdata(email.text, password.text);
              } else {
                SnackBar message = SnackBar(
                  content: Text('email must contain @acet '),
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(message);
              }
            },
            splashColor: Colors.redAccent,
            child: Container(
              height: 0.07 * height,
              width: 0.7 * width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff100d40),
              ),
              child: Center(
                child: Text(
                  "Sign up ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.15 * height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account ?",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff100d40),
                  height: 18 / 12,
                ),
                textAlign: TextAlign.left,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Log In",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff100d40),
                      height: 18 / 12,
                    ),
                    textAlign: TextAlign.left,
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
