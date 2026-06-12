import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/joke_list_screen.dart';
import '../screens/joke_detail_screen.dart';
import '../screens/favorites_screen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF6B35),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.grey.withValues(alpha: 0.2),
    ),
  );
}

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/categories': (context) => CategoryScreen(),
    '/jokes': (context) => const JokeListScreen(),
    '/joke-detail': (context) => const JokeDetailScreen(),
    '/favorites': (context) => const FavoritesScreen(),
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes App',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}