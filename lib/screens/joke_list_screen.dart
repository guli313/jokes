import 'package:flutter/material.dart';
import '../data/joke_data.dart';
import '../widgets/joke_card.dart';

class JokeListScreen extends StatelessWidget {
  const JokeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String category =
    ModalRoute.of(context)!.settings.arguments as String;

    final jokes = jokeData[category] ?? [];

    // Category colors map
    final Map<String, Color> categoryColors = {
      'Funny': const Color(0xFFFF6B35),
      'Programming': const Color(0xFF3498DB),
      'Dark': const Color(0xFF2C3E50),
      'Family': const Color(0xFF27AE60),
      'One Liner': const Color(0xFF9B59B6),
    };

    final color = categoryColors[category] ?? const Color(0xFFFF6B35);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,
        title: Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${jokes.length} Jokes',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Tap any joke to read more',
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
            child: jokes.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied_rounded,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No jokes available',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return _buildJokeCard(
                  context,
                  jokeText: jokes[index],
                  color: color,
                  index: index + 1,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/joke-detail',
                      arguments: jokes[index],
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

  Widget _buildJokeCard(
      BuildContext context, {
        required String jokeText,
        required Color color,
        required int index,
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
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jokeText,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey[800],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Tap to read more',
                          style: TextStyle(
                            fontSize: 13,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}