import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'service/initialize/initialize.dart';
import 'service/initialize/view/error_app.dart';

void main() async {
  runZonedGuarded(
    () async {
      final initializationProgress =
          ValueNotifier<({int progress, String message})>(
        (progress: 0, message: ''),
      );
      runApp(
        InitializationSplashScreen(
          progress: initializationProgress,
        ),
      );
      initializeApp(
        onProgress: (progress, message) => initializationProgress.value =
            (message: message, progress: progress),
        onSuccess: (dependencies) {
          runApp(
            InheritedDependencies(
              dependencies: dependencies,
              child: const MyHomeApp(),
            ),
          );
        },
        onError: (error, stackTrace) {
          runApp(ErrorApp(error: error));
        },
      ).ignore();
    },
    (error, stack) {
      log('main handler error --> $error ${stack.toString()}');
    },
  );
}
