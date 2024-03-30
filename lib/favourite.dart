import 'package:flutter/material.dart';
import 'data.dart';
import 'homepage.dart';

class Favourite extends StatefulWidget {
  Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Favourites!',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  for (int i = 0; i < recipes1.length; i++)
                    if (fav.contains(recipes1[i].id))
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
          )),
    );
  }
}
