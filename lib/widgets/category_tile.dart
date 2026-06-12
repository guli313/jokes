import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Category colors and emojis map
    final Map<String, Map<String, dynamic>> categoryData = {
      'Funny': {
        'color': const Color(0xFFFF6B35),
        'emoji': '😄',
      },
      'Programming': {
        'color': const Color(0xFF3498DB),
        'emoji': '💻',
      },
      'Dark': {
        'color': const Color(0xFF2C3E50),
        'emoji': '🌑',
      },
      'Family': {
        'color': const Color(0xFF27AE60),
        'emoji': '👨‍👩‍👧‍👦',
      },
      'One Liner': {
        'color': const Color(0xFF9B59B6),
        'emoji': '💬',
      },
    };

    final color = categoryData[categoryName]?['color'] ?? const Color(0xFFFF6B35);
    final emoji = categoryData[categoryName]?['emoji'] ?? '😄';

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