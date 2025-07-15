import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/home_screen.dart';

void main() {
  // 1
  runApp(const Yummy());
}

class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;

  ColorSelection colorSelected = ColorSelection.pink;

  void changeTheme(bool isLightMode) {
    setState(() {
      themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    //3
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner

      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      themeMode: themeMode,
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      // 4
      home: HomeScreen(
        changeTheme: changeTheme,
        changeColor: changeColor,
        colorSelected: colorSelected,
        appTitle: appTitle,
      ),
    );
  }
}
