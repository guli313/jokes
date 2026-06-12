import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JokeDetailScreen extends StatefulWidget {
  const JokeDetailScreen({Key? key}) : super(key: key);

  @override
  State<JokeDetailScreen> createState() => _JokeDetailScreenState();
}

class _JokeDetailScreenState extends State<JokeDetailScreen> {
  bool _isFavorite = false;

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Joke copied to clipboard!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String joke = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text(
          'Joke',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _copyToClipboard(joke);
            },
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        '😂',
                        style: TextStyle(fontSize: 45),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Enjoy the Joke!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.format_quote_rounded,
                    size: 40,
                    color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    joke,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                      color: Colors.grey[800],
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Transform.rotate(
                    angle: 3.14159,
                    child: Icon(
                      Icons.format_quote_rounded,
                      size: 40,
                      color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                      label: _isFavorite ? 'Favorited' : 'Favorite',
                      color: Colors.red,
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isFavorite
                                  ? 'Added to favorites!'
                                  : 'Removed from favorites!',
                            ),
                            backgroundColor: _isFavorite ? Colors.red : Colors.grey,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.copy_rounded,
                      label: 'Copy',
                      color: const Color(0xFF3498DB),
                      onTap: () {
                        _copyToClipboard(joke);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}