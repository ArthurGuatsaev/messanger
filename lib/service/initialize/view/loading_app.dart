part of '../initialize.dart';

class InitializationSplashScreen extends StatefulWidget {
  final ValueNotifier<({int progress, String message})> progress;
  const InitializationSplashScreen({super.key, required this.progress});

  @override
  State<InitializationSplashScreen> createState() =>
      _InitializationSplashScreenState();
}

class _InitializationSplashScreenState
    extends State<InitializationSplashScreen> {
  @override
  void initState() {
    widget.progress.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xff1A8476),
          body: Column(
            children: [
              const SizedBox(height: 250),
              Center(
                  child:
                      Image.asset('assets/logo.png', height: 242, width: 393)),
              const SizedBox(height: 100),
              const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              )
            ],
          )),
    );
  }
}
