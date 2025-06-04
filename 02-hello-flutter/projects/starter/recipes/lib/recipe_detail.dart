import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({required this.recipe, super.key});

  final Recipe recipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.label,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(widget.recipe.imageUrl),
            ),
            Text(
              widget.recipe.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: "Montserrat",
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final Ingredient ingredient =
                      widget.recipe.ingredients[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("${ingredient.quantity * sliderValue}"),
                    ),
                    title: Text(
                      ingredient.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      ingredient.measure.isNotEmpty
                          ? ingredient.measure
                          : "No measure",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  );
                },
              ),
            ),
            Slider(
              value: sliderValue.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  sliderValue = newValue.toInt();
                });
              },
              label: "${sliderValue * widget.recipe.servings} Servings",
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onPrimaryContainer,
              thumbColor: theme.colorScheme.primaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
