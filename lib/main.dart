import 'package:flutter/material.dart';
import 'login.dart';
import 'data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);

  // CheckData();
  // print('---------------------------------');
  // List<List<String>> valuesList = options.values.toList();
  // print(valuesList[1]);
  runApp(MaterialApp(
    // theme: ThemeData(
    //   scaffoldBackgroundColor: Color(0xFFE8E8E8),
    // ),
    debugShowCheckedModeBanner: false,
    home: SizedBox(
      height: 500.0,
      width: 500.0,
      child: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Icon(
          Icons.wine_bar,
          size: 80.0,
        ),
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        curve: Curves.easeInExpo,
        animationDuration: Duration(seconds: 1, milliseconds: 500),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('height: ');
    print(height);
    print('w');
    print(width);
    return Login();

    // return MaterialApp(
    //   theme: ThemeData.dark().copyWith(
    //     primaryColor: const Color(0xFF0A0E21),
    //     scaffoldBackgroundColor: const Color(0xFF0A0E21),
    //   ),
    //   home: Login(),
    // );
  }
}
