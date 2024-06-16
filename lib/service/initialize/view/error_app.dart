import 'package:flutter/material.dart';
import '../../themes/src/colors/color_constant.dart';

class ErrorApp extends StatelessWidget {
  final Object error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.bgLight,
        body: Center(child: Builder(builder: (context) {
          return const Text('Error');
        })),
      ),
    );
  }
}
