import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/joke_list_screen.dart';
import '../screens/joke_detail_screen.dart';
import '../screens/favorites_screen.dart';

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