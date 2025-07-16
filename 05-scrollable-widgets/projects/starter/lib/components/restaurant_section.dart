import 'package:flutter/material.dart';
import '../models/models.dart';
import 'restaurant_landscape_card.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key, required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Food Near Me',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                    width: 300,
                    child: RestaurantLandscapeCard(
                        restaurant: restaurants[index]));
              },
              itemCount: restaurants.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
