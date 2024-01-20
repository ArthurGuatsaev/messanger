import 'package:flutter/material.dart';
import 'package:messanger/pages/home.dart';

import 'themes/theme.dart';

void main() {
  runApp(const StyleApp());
}

class StyleApp extends StatelessWidget {
  const StyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: createLightTheme(),
      home: const HomePage(),
    );
  }
}
