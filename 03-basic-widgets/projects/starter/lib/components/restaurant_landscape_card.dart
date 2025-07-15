import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantLandscapeCard extends StatelessWidget {
  const RestaurantLandscapeCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ))),
          ListTile(
            title: Text(
              restaurant.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              restaurant.getRatingAndDistance(),
              style: textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
