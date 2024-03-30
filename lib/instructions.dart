import 'package:cocktail/bottomBar.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'homepage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Instructions extends StatefulWidget {
  Instructions({super.key, required this.j});
  int j;
  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  double userRating = 0;

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate this recipe"),
          content: RatingBar.builder(
            initialRating: userRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (newRating) {
              userRating = newRating;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                setState(() {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (!recipes1[widget.j].userRating.contains(user!.email)) {
                    recipes1[widget.j].userRating.add(user.email.toString());
                    recipes1[widget.j].total += userRating.toInt();
                    recipes1[widget.j].n += 1;
                  }
                });
                // Handle the user's rating, you can use the 'userRating' variable here

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color =
        fav.contains(recipes1[widget.j].id) ? Colors.red : Colors.white;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF95DDBE),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: height * 0.05,
                    left: height * 0.01,
                    right: height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => HomePage(),
                              //   ),
                              // );
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                        IconButton(
                            onPressed: () {
                              if (fav.contains(recipes1[widget.j].id)) {
                                setState(() {
                                  color = Colors.white;
                                  fav.remove(recipes1[widget.j].id);
                                  print(fav);
                                });
                              } else {
                                setState(() {
                                  color = Colors.red;
                                  fav.add(recipes1[widget.j].id);
                                  print(fav);
                                });
                              }
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: color,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          width: 200, // Adjust the width as per your needs.
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipes1[widget.j].name,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis, // This will add an ellipsis (...) if the text is truncated.
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star),
                                  Text((recipes1[widget.j].total /
                                          recipes1[widget.j].n)
                                      .toStringAsFixed(1))
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: ElevatedButton(
                                    onPressed: () {
                                      _showRatingDialog(context);
                                    },
                                    child: Text('Rate')),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                          child: Image.network(
                            recipes1img[widget.j],
                            width: width * 0.3, // Set the width of the image
                            height: 200.0, // Set the height of the image
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFD8E6E4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0;
                          i < recipes1[widget.j].ingredients.length;
                          i++)
                        ListTile(
                          leading: Icon(Icons
                              .fiber_manual_record), // You can use a different icon for bullets
                          title: Text(recipes1[widget.j].ingredients[i]),
                        ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        'Instructions',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0;
                          i < recipes1[widget.j].instructions.length;
                          i++)
                        ListTile(
                          leading: Icon(Icons
                              .fiber_manual_record), // You can use a different icon for bullets
                          title: Text(recipes1[widget.j].instructions[i]),
                        ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
