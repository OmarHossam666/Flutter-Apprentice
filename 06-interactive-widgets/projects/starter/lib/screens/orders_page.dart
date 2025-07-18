import 'package:flutter/material.dart';

import '../components/my_restaurant_card.dart';
import '../models/models.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MyRestaurantCard(restaurant: restaurants[index]);
      },
      itemCount: restaurants.length,
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }
}
