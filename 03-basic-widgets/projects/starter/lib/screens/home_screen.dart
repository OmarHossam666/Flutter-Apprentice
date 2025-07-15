import 'package:flutter/material.dart';

import '../components/category_card.dart';
import '../components/color_button.dart';
import '../components/post_card.dart';
import '../components/restaurant_landscape_card.dart';
import '../components/theme_button.dart';
import '../constants.dart';
import '../models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
  });

  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;
  final String appTitle;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home_filled),
    ),
    NavigationDestination(
      icon: Icon(Icons.post_add_outlined),
      label: 'Post',
      selectedIcon: Icon(Icons.post_add),
    ),
    NavigationDestination(
      icon: Icon(Icons.restaurant_outlined),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.restaurant),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: CategoryCard(foodCategory: categories[0]),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PostCard(post: posts[0]),
        ),
      ),
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: RestaurantLandscapeCard(restaurant: restaurants[0]),
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() {
            tab = value;
          });
        },
      ),
    );
  }
}
