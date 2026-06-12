import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String jokeText;
  final VoidCallback onTap;

  const JokeCard({
    Key? key,
    required this.jokeText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.sentiment_very_satisfied_rounded,
                    color: Colors.white,
                    size: 24,
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
                            color: const Color(0xFFFF6B35),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Color(0xFFFF6B35),
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