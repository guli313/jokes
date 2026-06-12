import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // App Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '😂',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Ready for some laughs?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.95),
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(),

              // Main Content Card
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Choose Your Fun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Categories Button
                    _buildMenuButton(
                      context,
                      icon: Icons.category_rounded,
                      title: 'Joke Categories',
                      subtitle: 'Browse jokes by category',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/categories');
                      },
                    ),

                    const SizedBox(height: 20),

                    // Favorites Button
                    _buildMenuButton(
                      context,
                      icon: Icons.favorite_rounded,
                      title: 'Favorites',
                      subtitle: 'Your saved jokes',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Gradient gradient,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}