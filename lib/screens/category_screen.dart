import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

/// ================================================================
/// FIRST 10 CHANGES (already present):
/// 1. Converted to a StatefulWidget so the screen can hold interactive state.
/// 2. Added a search bar to filter categories live by name.
/// 3. Added 2 new categories: "Riddles" and "Puns".
/// 4. Added a joke-count badge on each category card.
/// 5. Added a favorite (star) toggle per category, with favorites sorted first.
/// 6. Added haptic feedback when a category card is tapped.
/// 7. Added a staggered fade + slide-in entrance animation for the list.
/// 8. Added a grid/list view toggle button in the app bar.
/// 9. Added pull-to-refresh support (RefreshIndicator).
/// 10. Added an empty-state view for when a search returns no matches.
///
/// 10 MORE CHANGES ADDED IN THIS VERSION (11-20):
/// 11. Added a sort menu (A-Z, Z-A, Most Jokes, Favorites First).
/// 12. Added a short tagline/description under each category name.
/// 13. Added a "Clear favorites" action that appears only when favorites exist.
/// 14. Added a "NEW" badge on recently-added categories (Riddles, Puns).
/// 15. Added a total-jokes summary line in the header ("### jokes waiting").
/// 16. Added long-press on a card to open a bottom-sheet quick preview.
/// 17. Added a dark-mode toggle switch in the app bar.
/// 18. Added a shimmer-style loading skeleton during pull-to-refresh.
/// 19. Added a "Surprise Me" floating action button that jumps to a random category.
/// 20. Added a highlighted border on cards that are favorited.
/// ================================================================
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

enum _SortMode { favoritesFirst, alphaAsc, alphaDesc, mostJokes }

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Funny',
      'icon': Icons.sentiment_very_satisfied_rounded,
      'color': const Color(0xFFFF6B35),
      'emoji': '😄',
      'jokeCount': 128,
      'tagline': 'Feel-good laughs for any mood', // Change 12
      'isNew': false, // Change 14
      'sampleJoke': 'Why don\'t scientists trust atoms? Because they make up everything!', // Change 16
    },
    {
      'name': 'Programming',
      'icon': Icons.computer_rounded,
      'color': const Color(0xFF3498DB),
      'emoji': '💻',
      'jokeCount': 94,
      'tagline': 'Jokes only devs will truly get',
      'isNew': false,
      'sampleJoke': 'Why do programmers prefer dark mode? Because light attracts bugs.',
    },
    {
      'name': 'Dark',
      'icon': Icons.nightlight_round,
      'color': const Color(0xFF2C3E50),
      'emoji': '🌑',
      'jokeCount': 61,
      'tagline': 'Not for the faint of heart',
      'isNew': false,
      'sampleJoke': 'I told my therapist about my dark humor... she said it was a sign of intelligence.',
    },
    {
      'name': 'Family',
      'icon': Icons.family_restroom_rounded,
      'color': const Color(0xFF27AE60),
      'emoji': '👨‍👩‍👧‍👦',
      'jokeCount': 77,
      'tagline': 'Safe for the whole crew',
      'isNew': false,
      'sampleJoke': 'What do you call a bear with no teeth? A gummy bear!',
    },
    {
      'name': 'One Liner',
      'icon': Icons.format_quote_rounded,
      'color': const Color(0xFF9B59B6),
      'emoji': '💬',
      'jokeCount': 152,
      'tagline': 'Quick hits, maximum punch',
      'isNew': false,
      'sampleJoke': 'I used to be a banker, but I lost interest.',
    },
    {
      'name': 'Riddles',
      'icon': Icons.psychology_alt_rounded,
      'color': const Color(0xFFE67E22),
      'emoji': '🧩',
      'jokeCount': 48,
      'tagline': 'Put your brain to the test',
      'isNew': true, // Change 14
      'sampleJoke': 'What has keys but no locks? A piano.',
    },
    {
      'name': 'Puns',
      'icon': Icons.emoji_emotions_rounded,
      'color': const Color(0xFF16A085),
      'emoji': '🥁',
      'jokeCount': 85,
      'tagline': 'Groan-worthy wordplay',
      'isNew': true,
      'sampleJoke': 'I\'m reading a book on anti-gravity. It\'s impossible to put down.',
    },
  ];

  final Set<String> _favorites = {};
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _isGridView = false;
  bool _isDarkMode = false; // Change 17
  bool _isRefreshing = false; // Change 18
  _SortMode _sortMode = _SortMode.favoritesFirst; // Change 11

  late final AnimationController _animController;
  final Random _random = Random(); // Change 19

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  int get _totalJokes => // Change 15
  categories.fold(0, (sum, c) => sum + (c['jokeCount'] as int));

  List<Map<String, dynamic>> get _filteredCategories {
    var filtered = _query.isEmpty
        ? List<Map<String, dynamic>>.from(categories)
        : categories
        .where((c) =>
        (c['name'] as String).toLowerCase().contains(_query))
        .toList();

    // Change 11: apply chosen sort mode
    switch (_sortMode) {
      case _SortMode.favoritesFirst:
        filtered.sort((a, b) {
          final aFav = _favorites.contains(a['name']) ? 0 : 1;
          final bFav = _favorites.contains(b['name']) ? 0 : 1;
          return aFav.compareTo(bFav);
        });
        break;
      case _SortMode.alphaAsc:
        filtered.sort((a, b) =>
            (a['name'] as String).compareTo(b['name'] as String));
        break;
      case _SortMode.alphaDesc:
        filtered.sort((a, b) =>
            (b['name'] as String).compareTo(a['name'] as String));
        break;
      case _SortMode.mostJokes:
        filtered.sort((a, b) =>
            (b['jokeCount'] as int).compareTo(a['jokeCount'] as int));
        break;
    }
    return filtered;
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
  }

  void _clearFavorites() { // Change 13
    setState(() => _favorites.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Favorites cleared')),
    );
  }

  Future<void> _onRefresh() async { // Change 18: shimmer during refresh
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isRefreshing = false);
    _animController
      ..reset()
      ..forward();
  }

  void _surpriseMe() { // Change 19
    HapticFeedback.mediumImpact();
    final pick = categories[_random.nextInt(categories.length)];
    _openCategory(pick['name']);
  }

  void _showQuickPreview(Map<String, dynamic> item) { // Change 16
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item['emoji'], style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                Text(
                  item['name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '"${item['sampleJoke']}"',
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openCategory(item['name']);
                },
                child: const Text('See all jokes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCategories;
    final bg = _isDarkMode ? const Color(0xFF121212) : Colors.grey[50];
    final cardColor = _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.grey[900];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          // Change 17: dark mode toggle
          IconButton(
            icon: Icon(_isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded),
            tooltip: 'Toggle dark mode',
            onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
          ),
          // Change 11: sort menu
          PopupMenuButton<_SortMode>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'Sort categories',
            onSelected: (mode) => setState(() => _sortMode = mode),
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: _SortMode.favoritesFirst,
                  child: Text('Favorites first')),
              PopupMenuItem(
                  value: _SortMode.alphaAsc, child: Text('Name A-Z')),
              PopupMenuItem(
                  value: _SortMode.alphaDesc, child: Text('Name Z-A')),
              PopupMenuItem(
                  value: _SortMode.mostJokes, child: Text('Most jokes')),
            ],
          ),
          // Change 13: clear favorites (only shown if any exist)
          if (_favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.star_outline_rounded),
              tooltip: 'Clear favorites',
              onPressed: _clearFavorites,
            ),
          IconButton(
            icon: Icon(
                _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded),
            tooltip: _isGridView ? 'Switch to list view' : 'Switch to grid view',
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended( // Change 19
        onPressed: _surpriseMe,
        backgroundColor: const Color(0xFFFF6B35),
        icon: const Icon(Icons.shuffle_rounded),
        label: const Text('Surprise Me'),
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
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  '${categories.length} categories • $_totalJokes jokes waiting', // Change 15
                  style: TextStyle(
                      fontSize: 14, color: Colors.white.withValues(alpha: 0.9)),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search categories...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => _searchController.clear(),
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFFFF6B35),
              child: _isRefreshing // Change 18: shimmer skeleton
                  ? _buildShimmerSkeleton()
                  : (filtered.isEmpty
                  ? _buildEmptyState(textColor)
                  : (_isGridView
                  ? _buildGrid(filtered, cardColor, textColor)
                  : _buildList(filtered, cardColor, textColor))),
            ),
          ),
        ],
      ),
    );
  }

  // Change 18: simple shimmer-style loading skeleton
  Widget _buildShimmerSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.3, end: 0.7),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        builder: (context, value, child) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 96,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: value * 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color? textColor) {
    return ListView(
      children: [
        SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off_rounded, size: 60, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'No categories match "${_searchController.text}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor?.withValues(alpha: 0.7), fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(
      List<Map<String, dynamic>> items, Color cardColor, Color? textColor) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _AnimatedEntry(
          controller: _animController,
          index: index,
          child: _buildCategoryCard(
            context,
            item: item,
            cardColor: cardColor,
            textColor: textColor,
            isFavorite: _favorites.contains(item['name']),
            onFavoriteTap: () => _toggleFavorite(item['name']),
            onTap: () => _openCategory(item['name']),
            onLongPress: () => _showQuickPreview(item), // Change 16
          ),
        );
      },
    );
  }

  Widget _buildGrid(
      List<Map<String, dynamic>> items, Color cardColor, Color? textColor) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _AnimatedEntry(
          controller: _animController,
          index: index,
          child: _buildGridCard(
            context,
            item: item,
            cardColor: cardColor,
            textColor: textColor,
            isFavorite: _favorites.contains(item['name']),
            onFavoriteTap: () => _toggleFavorite(item['name']),
            onTap: () => _openCategory(item['name']),
            onLongPress: () => _showQuickPreview(item), // Change 16
          ),
        );
      },
    );
  }

  void _openCategory(String name) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/jokes', arguments: name);
  }

  Widget _buildCategoryCard(
      BuildContext context, {
        required Map<String, dynamic> item,
        required Color cardColor,
        required Color? textColor,
        required bool isFavorite,
        required VoidCallback onFavoriteTap,
        required VoidCallback onTap,
        required VoidCallback onLongPress,
      }) {
    final color = item['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress, // Change 16
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: isFavorite // Change 20: highlighted border for favorites
                ? Border.all(color: Colors.amber[600]!, width: 2)
                : null,
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(item['emoji'], style: const TextStyle(fontSize: 35)),
                    ),
                  ),
                  if (item['isNew'] == true) // Change 14: NEW badge
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
                    ),
                    const SizedBox(height: 3),
                    Text( // Change 12: tagline
                      item['tagline'] ?? '',
                      style: TextStyle(fontSize: 12.5, color: textColor?.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${item['jokeCount']} jokes',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                  color: isFavorite ? Colors.amber[600] : Colors.grey[400],
                ),
                onPressed: onFavoriteTap,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_forward_ios_rounded, color: color, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(
      BuildContext context, {
        required Map<String, dynamic> item,
        required Color cardColor,
        required Color? textColor,
        required bool isFavorite,
        required VoidCallback onFavoriteTap,
        required VoidCallback onTap,
        required VoidCallback onLongPress,
      }) {
    final color = item['color'] as Color;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress, // Change 16
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: isFavorite // Change 20
              ? Border.all(color: Colors.amber[600]!, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: 0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: Text(item['emoji'], style: const TextStyle(fontSize: 26))),
                    ),
                    if (item['isNew'] == true) // Change 14
                      Positioned(
                        top: -6,
                        right: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('NEW',
                              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                    color: isFavorite ? Colors.amber[600] : Colors.grey[400],
                    size: 22,
                  ),
                  onPressed: onFavoriteTap,
                ),
              ],
            ),
            const Spacer(),
            Text(
              item['name'],
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 3),
            Text( // Change 12
              item['tagline'] ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: textColor?.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${item['jokeCount']} jokes',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper widget that staggers a fade + slide-up entrance
/// for each card based on its index in the list/grid.
class _AnimatedEntry extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _AnimatedEntry({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.08).clamp(0.0, 0.7);
    final end = (start + 0.4).clamp(0.0, 1.0);
    final curved = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, (1 - curved.value) * 24),
            child: child,
          ),
        );
      },
    );
  }
}//ss
//ll
//pp
//ll