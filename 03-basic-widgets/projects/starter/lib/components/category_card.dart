import 'package:flutter/material.dart';

import '../models/food_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.foodCategory});

  final FoodCategory foodCategory;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.asset(foodCategory.imageUrl),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Text('Yummy', style: textTheme.headlineLarge),
              ),
              Positioned(
                  bottom: 16,
                  right: 16,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'Smoothies',
                      style: textTheme.headlineLarge,
                    ),
                  ))
            ],
          ),
          ListTile(
            title: Text(
              foodCategory.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              '${foodCategory.numberOfRestaurants} Places',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
