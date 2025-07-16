import 'package:flutter/material.dart';

import '../models/models.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.categories});

  final List<FoodCategory> categories;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Categories',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: CategoryCard(category: categories[index]),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
