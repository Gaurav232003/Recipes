import 'package:cocktail/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'search.dart';
import 'favourite.dart';
import 'data.dart';
import 'post.dart';

final GlobalKey<_BottomBarState> bottomBarKey = GlobalKey<_BottomBarState>();

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
// List of all the pages
  int selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    Search(),
    Favourite(),
    AddRecipePage(),

    // Add more screens here
  ];

  void toggle(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: GNav(
            gap: 8,
            // Need to make changes here for better looking bottom bar
            backgroundColor: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white,
            tabBorderRadius: 10.0,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            // padding: EdgeInsets.all(20.0),
            tabs: [
              GButton(
                icon: Icons.wine_bar,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Find',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Fav',
              ),
              GButton(
                icon: Icons.image,
                text: 'Images',
              ),
              // GButton(icon: Icons.forum)
            ],
          ),
        ),
        body: _screens[selectedIndex],
      ),
    );
  }
}
