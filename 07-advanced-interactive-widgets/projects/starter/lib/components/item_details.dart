import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_manager.dart';
import '../models/restaurant.dart';
import 'cart_control.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({
    super.key,
    required this.item,
    required this.cartManager,
    required this.onQuantityUpdated,
  });

  final Item item;
  final CartManager cartManager;
  final void Function() onQuantityUpdated;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.name,
                style: textTheme.headlineMedium,
              ),
              _buildMostLikedBadge(colorScheme),
              Text(
                widget.item.description,
                style: textTheme.bodyMedium,
              ),
              _buildItemImage(widget.item.imageUrl),
              _addToCartControl(widget.item),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMostLikedBadge(ColorScheme colorScheme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        color: colorScheme.onPrimary,
        child: const Text('#1 Most Liked'),
      ),
    );
  }

  Widget _buildItemImage(String imageUrl) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }

  Widget _addToCartControl(Item item) {
    return CartControl(
      item: item,
      addToCart: (int number) {
        const uuid = Uuid();
        final uniqueId = uuid.v4();
        final cartItem = CartItem(
          id: uniqueId,
          name: item.name,
          price: item.price,
          quantity: number,
        );

        setState(() {
          widget.cartManager.addItem(cartItem);
          widget.onQuantityUpdated();
        });

        Navigator.pop(context);
      },
    );
  }
}
