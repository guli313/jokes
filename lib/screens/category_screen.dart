import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Funny',
      'icon': Icons.sentiment_very_satisfied_rounded,
      'color': const Color(0xFFFF6B35),
      'emoji': '😄',
    },
    {
      'name': 'Programming',
      'icon': Icons.computer_rounded,
      'color': const Color(0xFF3498DB),
      'emoji': '💻',
    },
    {
      'name': 'Dark',
      'icon': Icons.nightlight_round,
      'color': const Color(0xFF2C3E50),
      'emoji': '🌑',
    },
    {
      'name': 'Family',
      'icon': Icons.family_restroom_rounded,
      'color': const Color(0xFF27AE60),
      'emoji': '👨‍👩‍👧‍👦',
    },
    {
      'name': 'One Liner',
      'icon': Icons.format_quote_rounded,
      'color': const Color(0xFF9B59B6),
      'emoji': '💬',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a Category',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${categories.length} categories available',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(
                  context,
                  categoryName: categories[index]['name'],
                  icon: categories[index]['icon'],
                  color: categories[index]['color'],
                  emoji: categories[index]['emoji'],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/jokes',
                      arguments: categories[index]['name'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, {
        required String categoryName,
        required IconData icon,
        required Color color,
        required String emoji,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Tap to explore',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}