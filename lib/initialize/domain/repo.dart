part of '../initialize.dart';

Future<Dependencies>? _$initializeApp;
Future<Dependencies> initializeApp({
  required Function(int progress, String message)? onProgress,
  required Function(Dependencies dependencies)? onSuccess,
}) {
  return _$initializeApp ??= Future<Dependencies>(() async {
    late WidgetsBinding buinding;
    final stopWatch = Stopwatch()..start();
    try {
      buinding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final dependencies = await $initializeDependencies(onProgress: onProgress)
          .timeout(const Duration(minutes: 5));
      await onSuccess?.call(dependencies);
      return dependencies;
    } on Object catch (error, stackTrace) {
      log('error: $error', stackTrace: stackTrace);
      rethrow;
    } finally {
      stopWatch.stop();
      buinding.addPostFrameCallback((_) {
        buinding.allowFirstFrame();
      });
    }
  });
}
