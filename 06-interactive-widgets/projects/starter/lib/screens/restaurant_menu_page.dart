import 'package:flutter/material.dart';

import '../components/my_restaurant_item.dart';
import '../models/restaurant.dart';

class RestaurantMenuPage extends StatelessWidget {
  const RestaurantMenuPage({
    super.key,
    required this.items,
    required this.restaurantName,
  });

  final List<Item> items;
  final String restaurantName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MyRestaurantItem(item: items[index]);
        },
        itemCount: items.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
