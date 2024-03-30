// ignore_for_file: use_build_context_synchronously, must_be_immutable, unnecessary_new

import 'package:cocktail/loadingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'register.dart';
import 'functions.dart';
import 'widgets.dart';
import 'homepage.dart';
import 'bottomBar.dart';
// import 'homepage.dart';
// import 'data.dart';
import 'loadingpage.dart';

class Login extends StatelessWidget {
  Login({super.key});

  TextEditingController email1 = TextEditingController();

  TextEditingController pass1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginSphere(
                text: 'LOGIN',
                img: 'assets/loginsphere.png',
              ),
              SizedBox(
                height: height * 0.0264,
              ),
              Center(
                child: Text(
                  'Hey There!!',
                  style: TextStyle(
                      fontSize: height * 0.039, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 0.049 * height,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.127, right: width * 0.076),
                child: Text(
                  'One-Stop Solution for all your Recipe requirements!!',
                  style: TextStyle(
                      fontSize: height * 0.0319, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: height * 0.073,
              ),

              // Login  and Password
              LoginPlateTextField(
                con: email1,
                icon: Icons.person,
                hintText: 'Username',
                // obscuretext: false,
              ),
              SizedBox(
                height: height * 0.0246,
              ),
              LoginPlateTextField(
                  con: pass1,
                  // obscuretext: true,
                  icon: Icons.key,
                  hintText: 'Password'),
              SizedBox(
                height: height * 0.0246,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.147, right: width * 0.147),
                child: ElevatedButton(
                    onPressed: () async {
                      print(email1.text);
                      print(pass1.text);
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: 'gaurav@dev.in', //'gaurav@dev.com',
                        password: '12345678',
                      );

                      // int t = await fetchImages();
                      // int p = await fetchdetails();
                      // Navigator.pushReplacement(
                      //   context,
                      //   new MaterialPageRoute(
                      //     builder: (BuildContext context) => BottomBar(),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoadingPage();
                          },
                        ),
                      );
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CA3B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('L O G I N')),
              ),
              SizedBox(
                height: height * 0.036,
              ),
              const LineOrLine(),
              SizedBox(
                height: height * 0.036,
              ),
              const SignInWithGoogle(),
              SizedBox(
                height: height * 0.012,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?'),
                  SizedBox(
                    width: width * 0.025,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
