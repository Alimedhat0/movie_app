import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/helpers/local_storage.dart';
import 'package:flutter_application_1/core/networking/dio_factory.dart';
import 'package:flutter_application_1/core/style/themes.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/splash/ui/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioFactory.init();
  await LocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeMovieProvider(),
      child: Consumer<HomeMovieProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Movie Verse',
            debugShowCheckedModeBanner: false,
            theme:
                provider.getIsDark()
                    ? AppThemes.darkTheme
                    : AppThemes.lightTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
