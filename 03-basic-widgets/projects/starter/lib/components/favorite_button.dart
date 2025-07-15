import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool? isFavorite;

  @override
  void initState() {
    super.initState();
    // Initialize the favorite state, if needed
    isFavorite = false; // or fetch from a model or service
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleFavorite,
      icon: Icon(
        isFavorite! ? Icons.favorite : Icons.favorite_border,
        color: isFavorite! ? Colors.red : Colors.grey,
      ),
    );
  }
}
