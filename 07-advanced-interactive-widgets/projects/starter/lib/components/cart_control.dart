import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class CartControl extends StatefulWidget {
  const CartControl({super.key, required this.item, required this.addToCart});

  final Item item;
  final void Function(int) addToCart;

  @override
  State<CartControl> createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int _itemNumber = 1;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMinusButton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddToCartButton(),
      ],
    );
  }

  Widget _buildMinusButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_itemNumber > 1) {
            _itemNumber--;
          }
        });
      },
      icon: const Icon(Icons.remove),
    );
  }

  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.onPrimary,
      child: Text(_itemNumber.toString()),
    );
  }

  Widget _buildPlusButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _itemNumber++;
        });
      },
      icon: const Icon(Icons.add),
    );
  }

  Widget _buildAddToCartButton() {
    return FilledButton(
      onPressed: () => widget.addToCart(_itemNumber),
      child: const Text('Add to Cart'),
    );
  }
}
