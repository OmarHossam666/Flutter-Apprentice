import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';
import 'package:recipes/recipe_detail.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Recipe App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Recipe App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            color: theme.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: Recipe.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(recipe: Recipe.recipes[index],),
                  ),
                );
              },
              child: buildRecipeCard(Recipe.recipes[index]),
            );
          },
        ),
      ),
    );
  }
}

Widget buildRecipeCard(Recipe recipe) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 2,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Image.asset(recipe.imageUrl),
          Text(
            recipe.label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "Montserrat",
            ),
          ),
        ],
      ),
    ),
  );
}