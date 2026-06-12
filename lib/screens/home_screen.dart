import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _jokes = [
    {
      'setup': 'Why don\'t scientists trust atoms?',
      'punchline': 'Because they make up everything!',
    },
    {
      'setup': 'Why did the scarecrow win an award?',
      'punchline': 'Because he was outstanding in his field!',
    },
    {
      'setup': 'I told my wife she was drawing her eyebrows too high.',
      'punchline': 'She looked surprised.',
    },
    {
      'setup': 'Why can\'t you give Elsa a balloon?',
      'punchline': 'Because she\'ll let it go!',
    },
    {
      'setup': 'I\'m reading a book about anti-gravity.',
      'punchline': 'It\'s impossible to put down!',
    },
  ];

  int _jokeIndex = 0;
  bool _showPunchline = false;

  void _nextJoke() {
    setState(() {
      _jokeIndex = (_jokeIndex + 1) % _jokes.length;
      _showPunchline = false;
    });
  }

  void _revealPunchline() {
    setState(() {
      _showPunchline = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final joke = _jokes[_jokeIndex];

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                        color: Colors.black.withOpacity(0.15),
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
                    color: Colors.white.withOpacity(0.95),
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 20),

                // ── Daily Joke Card ──────────────────────────────────────
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('🎯', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            'Joke of the Moment',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Setup line
                      Text(
                        joke['setup']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Punchline line (tap to reveal)
                      GestureDetector(
                        onTap: _showPunchline ? null : _revealPunchline,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _showPunchline
                              ? Text(
                            joke['punchline']!,
                            key: const ValueKey('punchline'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          )
                              : Container(
                            key: const ValueKey('tap'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Tap to reveal punchline 👆',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Next joke button
                      GestureDetector(
                        onTap: _nextJoke,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Next Joke ➡',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B35),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Main Content Card ────────────────────────────────────
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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

                const SizedBox(height: 20),

                // ── Not Interested Button ────────────────────────────────
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text(
                          'Not Interested?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'We\'re sorry to hear that! Would you like to give us feedback on how we can improve?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Dismiss',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Give Feedback',
                              style: TextStyle(color: Color(0xFFFF6B35)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_down_alt_outlined,
                          color: Colors.white.withOpacity(0.85),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Not Interested',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
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
              color: Colors.black.withOpacity(0.1),
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
                color: Colors.white.withOpacity(0.3),
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
                      color: Colors.white.withOpacity(0.9),
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