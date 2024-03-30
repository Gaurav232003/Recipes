import 'package:cocktail/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'instructions.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () async {
            DatabaseReference ref = FirebaseDatabase.instance.ref("recipes1/2");
            await ref.set({
              "name": 'Quinoa Stuffed Bell Peppers',
              "id": 2,
              "ingredients": [
                'bell peppers',
                'quinoa',
                'black beans',
                'corn kernels',
                'tomatoes',
                'cumin',
              ],
              "instructions": [
                "Cook pasta according to package instructions.",
                "Halve cherry tomatoes and mince garlic.",
                "In a pan, heat olive oil and sauté garlic until fragrant.",
                "Add cherry tomatoes, salt, and pepper. Cook until tomatoes soften.",
                "Toss cooked pasta with tomato mixture and chopped basil.",
                "Serve hot, garnished with extra basil leaves if desired."
              ],
              "userRating": ['gaurav2@dev.in'],
              "total": 17,
              "n": 4,
              "type": 'v',
            });
          }),
          backgroundColor: Color(0xFFD5E4E2),
          body: Padding(
            padding: EdgeInsets.only(
                top: height * 0.05, left: height * 0.05, right: height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Recipes For You!',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text('Veg'),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  for (int i = 0; i < recipes1.length; i++)
                    if ((isChecked && recipes1[i].type != 'n') || !isChecked)
                      Column(
                        children: [
                          HomeBox(color: Color(0xFF95DDBE), j: i),
                          SizedBox(
                            height: height * 0.05,
                          )
                        ],
                      ),
                ],
              ),
            ),
          )),
    );
  }
}

class HomeBox extends StatelessWidget {
  HomeBox({super.key, required this.color, required this.j});

  Color color;
  int j;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Instructions(j: j)),
        );
      },
      child: Container(
        height: height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Row(
          children: [
            // Left side with Network Image
            Container(
              // Adjust the padding as needed
              child: Image.network(
                recipes1img[j],
                width: width * 0.3, // Set the width of the image
                height: height * 0.25, // Set the height of the image
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
            // Right side with Text
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10.0), // Adjust the padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipes1[j].name,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      for (int i = 0;
                          i <
                              recipes1[j].ingredients.length -
                                  recipes1[j].ingredients.length % 2;
                          i += 2)
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10.0),
                                  elevation: height * 0.015,
                                  child: Container(
                                    height: height * 0.03,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                      child: Text(
                                        recipes1[j].ingredients[i],
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10.0),
                                  elevation: height * 0.015,
                                  child: Container(
                                    height: height * 0.03,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                      child: Text(
                                        recipes1[j].ingredients[i + 1],
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (recipes1[j].ingredients.length % 2 == 1)
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10.0),
                                  elevation: height * 0.015,
                                  child: Container(
                                    height: height * 0.03,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                      child: Text(
                                        recipes1[j].ingredients[
                                            recipes1[j].ingredients.length - 1],
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
