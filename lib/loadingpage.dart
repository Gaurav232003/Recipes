import 'package:cocktail/functions.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'homepage.dart';
import 'bottomBar.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String loadingMessage = 'Fetching Data...'; // Initial loading message

  @override
  void initState() {
    super.initState();
    fetchAndNavigate();
  }

  Future<void> fetchAndNavigate() async {
    try {
      int t = await fetchImages();
      int p = await fetchdetails();

      // Once the data is fetched, navigate to another page or handle it as needed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BottomBar();
          },
        ),
      );
    } catch (e) {
      setState(() {
        loadingMessage =
            'Error: $e'; // Display an error message if data fetching fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add a rotating icon or image
            AnimatedBuilder(
              animation: AlwaysStoppedAnimation(0),
              builder: (context, child) {
                return Transform.rotate(
                  angle:
                      6.283, // 6.283 radians = 360 degrees (one full rotation)
                  child: Icon(
                    Icons.wine_bar, // You can use any rotating icon or image
                    size: 50,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
                loadingMessage), // Display the loading message or error message
          ],
        ),
      ),
    );
  }
}
