import 'package:flutter/material.dart';
import 'data.dart';
import 'homepage.dart';

class Possible extends StatelessWidget {
  Possible({super.key, required this.drinks});
  List<String> drinks;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFD5E4E2),
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.05, left: height * 0.05, right: height * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Possible Recipes!'),
                SizedBox(
                  height: height * 0.05,
                ),
                for (int i = 0; i < recipes1.length; i++)
                  if (drinks.contains(recipes1[i].name))
                    Column(
                      children: [
                        HomeBox(color: Color(0xFF95DDBE), j: i),
                        SizedBox(
                          height: height * 0.05,
                        )
                      ],
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
