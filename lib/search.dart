import 'package:flutter/material.dart';
import 'data.dart';
import 'possible.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  List<String> selectedItems = [];
  List<String> displayedItems =
      List.from(ingredients); // Initialize with all items

  void toggleCheckbox(String item) {
    if (selectedItems.contains(item)) {
      setState(() {
        selectedItems.remove(item);
        print(selectedItems);
      });
    } else {
      setState(() {
        selectedItems.add(item);
        print(selectedItems);
      });
    }
  }

  void filterItems(String query) {
    query = query.toLowerCase();
    setState(() {
      displayedItems = ingredients
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Enter a search term',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                        onChanged: (text) {
                          filterItems(text);
                        },
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the "Go" button action here
                        // You can use _searchController.text for the search term

                        List<String> userIngredients = selectedItems;
// List to store the names of drinks the user can make
                        List<String> makeableDrinks = [];

// Iterate through the recipes and check if the ingredients are a subset
                        for (Recipes recipe in recipes1) {
                          List<String> recipeIngredients = recipe.ingredients;

                          // Check if all recipeIngredients are in userIngredients
                          if (recipeIngredients.every((ingredient) =>
                              userIngredients.contains(ingredient))) {
                            makeableDrinks.add(recipe.name);
                          }
                        }

// Display the list of drinks the user can make
                        print("You can make the following dishes:");
                        for (String drinkName in makeableDrinks) {
                          print(drinkName);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Possible(
                                    drinks: makeableDrinks,
                                  )),
                        );
                      },
                      child: Text('Go'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                for (int i = 0; i < displayedItems.length; i++)
                  Column(
                    children: [
                      Container(
                        height: height * 0.1,
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFD7C1C1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(displayedItems[i]),
                            Checkbox(
                              value: selectedItems.contains(displayedItems[i]),
                              onChanged: (value) {
                                toggleCheckbox(displayedItems[i]);
                              },
                            ),
                          ],
                        ),
                      ),
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
