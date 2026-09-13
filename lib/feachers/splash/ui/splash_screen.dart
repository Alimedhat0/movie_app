import 'package:flutter/material.dart';
import 'package:flutter_application_1/feachers/movie/ui/movie_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MovieScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.red, Colors.amber],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
              child: Icon(
                Icons.play_circle_outline_outlined,
                size: 100,
                color: Colors.white,
              ),
            ),
            Text(
              'Movie Verse',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
