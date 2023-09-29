import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepalsa/services/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late User? loginuserdetail;
  Services manager = Services();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void logindata(String email, String password, BuildContext context) async {
      loginuserdetail = await manager.login(email, password, context);
      if (loginuserdetail != null) {
        print('function runned successfully ');

        Navigator.pushNamed(context, '/message');
      } else {
        print('sorry');
      }
    }

    int checkemail(String email) {
      if (email.contains('@acet')) {
        return 1;
      } else {
        return 0;
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 0.15 * height),
              height: 0.15 * height,
              width: double.infinity,
              child: Hero(tag: 'logo', child: Image.asset('assets/logo.png'))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
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
            margin:
                EdgeInsets.symmetric(horizontal: 10, vertical: 0.04 * height),
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
                logindata(email.text, password.text, context);
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
                  "Log in ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.1 * height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account ?",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999999),
                  height: 18 / 12,
                ),
                textAlign: TextAlign.left,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Sign Up",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
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
