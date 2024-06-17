import 'package:flutter/material.dart';
import 'screens/phone/phone_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return switch (constraints.minWidth) {
        < 450 => const PhoneHome(),
        _ => const PhoneHome(),
      };
    });
  }
}
