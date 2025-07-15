import 'package:flutter/material.dart';
import '../constants.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    required this.changeColor,
    required this.colorSelected,
  });

  final Function(int) changeColor;
  final ColorSelection colorSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton(
      icon: Icon(Icons.color_lens_outlined,
          color: theme.colorScheme.onSurfaceVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSelection.values.length, (index) {
          final currentColor = ColorSelection.values[index];
          return PopupMenuItem<int>(
            value: index,
            enabled: currentColor != colorSelected,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.colorize_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: currentColor == colorSelected
                              ? currentColor.color
                              : theme.colorScheme.onSurfaceVariant)),
                )
              ],
            ),
          );
        });
      },
      onSelected: changeColor,
    );
  }
}
