import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class MyRestaurantItem extends StatelessWidget {
  const MyRestaurantItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: colorScheme.onInverseSurface,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // TODO: Implement like functionality
                          },
                          icon: Icon(
                            Icons.thumb_up_outlined,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 120,
                          color: colorScheme.onSurfaceVariant,
                          child: Icon(
                            Icons.image_not_supported,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 120,
                          height: 120,
                          color: colorScheme.onSurfaceVariant,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: FilledButton.tonal(
                      onPressed: () {
                        // TODO: Implement add to cart functionality
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(60, 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                      ),
                      child: Text(
                        'Add',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
