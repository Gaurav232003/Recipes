double height = 0;
double width = 0;
int count = 0;

class Recipes {
  Recipes(
      {required this.type,
      required this.name,
      required this.id,
      required this.imgUrl,
      required this.ingredients,
      required this.instructions,
      required this.userRating,
      required this.total,
      required this.n});
  String type;
  List<String> ingredients;
  List<String> instructions;
  String name;
  String imgUrl;
  int id;
  List<String> userRating;
  int total, n;
}

List<String> recipes1img = [];
List<String> recipes2img = [];
List<String> images = [];

List<Recipes> recipes1 = [];

List<Recipes> recipes2 = [];

List<String> ingredients = [
  "pasta",
  "cherry tomatoes",
  "cloves garlic",
  "fresh basil",
  "olive oil",
  "bell peppers",
  "quinoa",
  "corn kernels",
  "black beans",
  "cumin",
  "paprika",
  "avocados",
  "tomato",
  "red onion",
  "cilantro",
  "lime",
  "mixed vegetables",
  "garlic",
  "onion",
  "soy sauce",
  "cornstarch",
  "sesame oil",
  "shrimp",
  "butter",
  "lemon",
  "parsley",
  "chicken breasts",
  "yogurt",
  "tandoori masala",
  "ginger",
  "spaghetti",
  "bacon",
  "eggs",
  "cheese",
  "soy sauce",
  "salmon fillets",
  "honey",
  "vinegar",
];
List<int> fav = [1, 3];
