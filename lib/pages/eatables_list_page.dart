import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import '../models/food_item.dart';

class EatablesListPage extends StatefulWidget {
  const EatablesListPage({super.key});

  @override
  State<EatablesListPage> createState() => _EatablesListPageState();
}

class _EatablesListPageState extends State<EatablesListPage>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  Set<String> _favorites = {};
  bool _showOnlyFavorites = false;
  late List<FoodItem> foodItems;
  final Map<String, AnimationController> _controllers = {};
  final Map<String, Animation<double>> _scaleAnimations = {};

  Map<String, String> foodImages = {
    'Burger': '',
    'Pizza': '',
    'Fries': '',
    'Nuggets': '',
    'Shawarma': '',
    'Pasta': '',
    'Samosa': '',
    'Kabab': '',
    'Biryani': '',
    'Karahi': '',
    'Nihari': '',
    'Gulab Jamun': '',
    'Rasmalai': '',
    'Kheer': '',
    'Club': '',
    'Sub': '',
    'Roll': '',
    'Spring Rolls': '',
    'Tikka': '',
    'Paneer': '',
    'Rogan Josh': '',
  };

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    foodItems = loadFoodItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = Set<String>.from(prefs.getStringList('favorites') ?? []);
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.toList());
  }

  AnimationController _createAnimationController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _ensureAnimationExists(String itemName) {
    if (!_controllers.containsKey(itemName)) {
      _controllers[itemName] = _createAnimationController();
      _scaleAnimations[itemName] = Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(
          parent: _controllers[itemName]!,
          curve: Curves.elasticOut,
        ),
      );
    }
  }

  void _toggleFavorite(String itemName) {
    setState(() {
      _ensureAnimationExists(itemName);
      if (_favorites.contains(itemName)) {
        _favorites.remove(itemName);
        _controllers[itemName]?.reverse();
      } else {
        _favorites.add(itemName);
        _controllers[itemName]?.forward();
      }
      _saveFavorites();
    });
  }

  List<FoodItem> _getFilteredItems(String query) {
    if (_showOnlyFavorites) {
      return foodItems
          .where((item) =>
              _favorites.contains(item.name) &&
              (query.isEmpty ||
                  item.name.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    if (query.isEmpty) {
      return foodItems;
    }
    return foodItems
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.searchKeywords.any((keyword) =>
                keyword.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  List<FoodItem> loadFoodItems() {
    return [
      FoodItem(
        name: 'Burger',
        restaurant: 'Crust Bros',
        description: 'Crispy chicken with mayo and lettuce in sesame bun',
        price: 'Rs.399',
        searchKeywords: [
          'crispy',
          'zinger',
          'mayo',
          'lettuce',
          'sesame bun',
          'burger'
        ],
        imageUrl: '',
        size: 'Regular',
      ),
      FoodItem(
        name: 'Pizza',
        restaurant: 'Crust Bros',
        description: 'Fresh and hot pizza with special toppings',
        price: 'Rs.649',
        searchKeywords: ['pizza', 'cheese', 'italian'],
        imageUrl: '',
        size: 'Large',
      ),
      FoodItem(
        name: 'Biryani',
        restaurant: 'Nawab Hotel',
        description: 'Special biryani with aromatic rice and spices',
        price: 'Rs.500',
        searchKeywords: ['biryani', 'rice', 'spicy'],
        imageUrl: '',
        size: 'Full',
      ),
      FoodItem(
        name: 'Karahi',
        restaurant: 'Nawab Hotel',
        description: 'Traditional karahi with fresh ingredients',
        price: 'Rs.700',
        searchKeywords: ['karahi', 'curry', 'spicy'],
        imageUrl: '',
        size: 'Full',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> items = _getFilteredItems(_searchController.text);
    if (items.isEmpty) {
      return Center(child: Text("No items found"));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          },
        ),
        title: const Text(
          'List of eatables Jahanian',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: _showOnlyFavorites ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showOnlyFavorites = !_showOnlyFavorites;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Find the list of items in jahanian',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildFoodItemCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItemCard(FoodItem item) {
    _ensureAnimationExists(item.name);
    bool isFavorite = _favorites.contains(item.name);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: ScaleTransition(
                  scale: _scaleAnimations[item.name]!,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(item.name),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.restaurant,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
