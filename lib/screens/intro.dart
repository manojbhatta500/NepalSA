import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: 0.07 * height, horizontal: 0.1 * width),
                height: 0.4 * height,
                width: double.infinity,
                child:
                    Hero(tag: 'logo', child: Image.asset('assets/logo.png'))),
            Text(
              'Nepal Student association',
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
                height: 18 / 12,
              ),
            ),
            SizedBox(
              height: 0.15 * height,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                height: 0.08 * height,
                width: 0.8 * width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff100d40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's start",
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: Color(0xff999999),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
