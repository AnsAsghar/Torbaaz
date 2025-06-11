import 'package:flutter/material.dart';
import '../utils/database_service.dart';
import 'restaurant_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/deal_fullscreen_viewer.dart';

class FoodDealsPage extends StatefulWidget {
  const FoodDealsPage({super.key});

  @override
  State<FoodDealsPage> createState() => _FoodDealsPageState();
}

class _FoodDealsPageState extends State<FoodDealsPage> {
  final _databaseService = DatabaseService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allDeals = [];
  List<Map<String, dynamic>> _filteredDeals = [];
  List<Map<String, dynamic>> _restaurants = [];
  Set<int> _favoriteDeals = {};
  bool _isLoading = true;
  bool _showOnlyFavorites = false;
  String _selectedRestaurant = 'All Restaurants';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    try {
      // First try to load from local storage
      final prefs = await SharedPreferences.getInstance();
      final localFavorites = prefs.getStringList('dealFavorites') ?? [];

      // Then try to load from database if user is logged in
      final dbFavorites = await _databaseService.getUserFavorites();

      setState(() {
        // Combine both sources of favorites
        _favoriteDeals = Set<int>.from([
          ...localFavorites.map((id) => int.parse(id)),
          ...dbFavorites,
        ]);
      });
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      // If there's an error, still try to load from local storage
      final prefs = await SharedPreferences.getInstance();
      final localFavorites = prefs.getStringList('dealFavorites') ?? [];
      setState(() {
        _favoriteDeals = Set<int>.from(
          localFavorites.map((id) => int.parse(id)),
        );
      });
    }
  }

  Future<void> _saveFavoritesToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'dealFavorites',
        _favoriteDeals.map((id) => id.toString()).toList(),
      );
    } catch (e) {
      debugPrint('Error saving favorites to local storage: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Load deals
      final deals = await _databaseService.getDeals();

      // If no deals are returned from the database, create sample deals from the dataset
      List<Map<String, dynamic>> allDeals = deals;
      if (allDeals.isEmpty) {
        allDeals = _createSampleDeals();
      }

      // Load restaurants
      final restaurants = await _databaseService.getRestaurants();

      // If no restaurants are returned, add sample restaurants
      List<Map<String, dynamic>> allRestaurants = restaurants;
      if (allRestaurants.isEmpty) {
        allRestaurants = _createSampleRestaurants();
      }

      // Remove Pizza Point restaurant as it's not in Jahanian
      final jahanianRestaurants = allRestaurants
          .where((restaurant) => !restaurant['name']
              .toString()
              .toLowerCase()
              .contains('pizza point'))
          .toList();

      // Load favorites
      await _loadFavorites();

      setState(() {
        _allDeals = allDeals;
        _filteredDeals = _filterDeals();
        _restaurants = jahanianRestaurants;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading data: $e';
        _isLoading = false;

        // Even if there's an error, populate with sample data
        _allDeals = _createSampleDeals();
        _restaurants = _createSampleRestaurants();
        _filteredDeals = _filterDeals();
      });
    }
  }

  // Create sample deals from dataset.txt
  List<Map<String, dynamic>> _createSampleDeals() {
    final List<Map<String, dynamic>> sampleDeals = [];
    int id = 1;

    // Meet N Eat deals
    final meetNEatRestaurant = {
      'id': 1,
      'name': 'Meet N Eat',
      'description': 'Fast food and deals restaurant in Jahanian',
      'contact_number': '0328-5500112, 0310-5083300',
      'address': 'Opposite Nadra Office, Multan Road, Jahanian',
    };

    sampleDeals.addAll([
      {
        'id': id++,
        'title': 'Deal 1',
        'description': '1 Zinger Burger, Small Fries, 350ml Soft Drink',
        'price': 600,
        'is_featured': true,
        'discount_percentage': 15,
        'image_url':
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
        'restaurants': meetNEatRestaurant,
      },
      {
        'id': id++,
        'title': 'Deal 2',
        'description': '1 Mighty Burger, Regular Fries, 350ml Soft Drink',
        'price': 800,
        'is_featured': false,
        'discount_percentage': 10,
        'image_url':
            'https://images.unsplash.com/photo-1610614819513-58e34989e371',
        'restaurants': meetNEatRestaurant,
      },
      {
        'id': id++,
        'title': 'Deal 3',
        'description':
            '2 Zinger Burgers, 2 Pieces Crispy Wings, Small Fries, 500ml Soft Drink',
        'price': 1100,
        'is_featured': true,
        'discount_percentage': 20,
        'image_url':
            'https://images.unsplash.com/photo-1550547660-d9450f859349',
        'restaurants': meetNEatRestaurant,
      },
    ]);

    // Crust Bros deals
    final crustBrosRestaurant = {
      'id': 2,
      'name': 'Crust Bros',
      'description': 'Pizza and fast food restaurant in Jahanian',
      'contact_number': '0325-8003399, 0327-8003399',
      'address': 'Loha Bazar, Jahanian',
    };

    sampleDeals.addAll([
      {
        'id': id++,
        'title': 'Special Platter',
        'description': '4 Pcs Spin Roll, 6 Pcs Wings, Fries & Dip Sauce',
        'price': 1050,
        'is_featured': false,
        'discount_percentage': 10,
        'image_url':
            'https://images.unsplash.com/photo-1615557960916-c7a0cd85b9fb',
        'restaurants': crustBrosRestaurant,
      },
    ]);

    // EatWay deals
    final eatWayRestaurant = {
      'id': 8,
      'name': 'EatWay',
      'description': 'Pizza and fast food restaurant in Jahanian',
      'contact_number': '0301-0800777, 0310-0800777',
      'address': 'Rehmat Villas, Phase 1, Canal Road, Jahanian',
    };

    sampleDeals.addAll([
      {
        'id': id++,
        'title': 'Regular Pizzas Deal',
        'description':
            '6 inches - Rs. 599, 9 inches - Rs. 1099, 12 inches - Rs. 1399',
        'price': 599,
        'is_featured': true,
        'discount_percentage': 15,
        'image_url':
            'https://images.unsplash.com/photo-1594007654729-407eedc4fe24',
        'restaurants': eatWayRestaurant,
      },
    ]);

    // Pizza Slice deals
    final pizzaSliceRestaurant = {
      'id': 5,
      'name': 'Pizza Slice',
      'description': 'Pizza and fast food in Jahanian',
      'contact_number': '0308-4824792, 0311-4971155',
      'address':
          'Main Khanewall Highway Road, Infront of Qudas Masjid Jahanian',
    };

    sampleDeals.addAll([
      {
        'id': id++,
        'title': 'Deal 1',
        'description': '5 Zinger Burger, 1.5 Ltr. Drink',
        'price': 1700,
        'is_featured': true,
        'discount_percentage': 15,
        'image_url':
            'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47',
        'restaurants': pizzaSliceRestaurant,
      },
      {
        'id': id++,
        'title': 'Deal 3',
        'description': '1 Small Pizza, 1 Zinger Burger, 1 Reg. Drink',
        'price': 1200,
        'is_featured': false,
        'discount_percentage': 10,
        'image_url':
            'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        'restaurants': pizzaSliceRestaurant,
      },
    ]);

    // Miran Jee Food Club deals
    final miranJeeRestaurant = {
      'id': 4,
      'name': 'Miran Jee Food Club (MFC)',
      'description': 'Fast food restaurant in Jahanian',
      'contact_number': '0309-7000178, 0306-7587938',
      'address': 'Near Ice Factory, Rahim Shah Road, Jahanian',
    };

    sampleDeals.addAll([
      {
        'id': id++,
        'title': 'Deal 1',
        'description': '1 Chicken Burger, 1500ml Drink',
        'price': 390,
        'is_featured': true,
        'discount_percentage': 15,
        'image_url':
            'https://images.unsplash.com/photo-1610614819513-58e34989e371',
        'restaurants': miranJeeRestaurant,
      },
    ]);

    return sampleDeals;
  }

  // Create sample restaurants from dataset.txt
  List<Map<String, dynamic>> _createSampleRestaurants() {
    return [
      {
        'id': 1,
        'name': 'Meet N Eat',
        'description': 'Fast food and deals restaurant in Jahanian',
        'contact_number': '0328-5500112, 0310-5083300',
        'address': 'Opposite Nadra Office, Multan Road, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
        'rating': 4.5,
      },
      {
        'id': 2,
        'name': 'Crust Bros',
        'description': 'Pizza and fast food restaurant in Jahanian',
        'contact_number': '0325-8003399, 0327-8003399',
        'address': 'Loha Bazar, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
        'rating': 4.2,
      },
      {
        'id': 3,
        'name': 'Khana Khazana',
        'description':
            'Traditional Pakistani cuisine with special deals and family platters',
        'contact_number': '0345-7277634, 0309-4152186',
        'address':
            'Main Super Highway Bahawal Pur Road, Near Total Petrol Pump Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1547496502-affa22d38842',
        'rating': 4.3,
      },
      {
        'id': 4,
        'name': 'Miran Jee Food Club (MFC)',
        'description': 'Fast food restaurant in Jahanian',
        'contact_number': '0309-7000178, 0306-7587938',
        'address': 'Near Ice Factory, Rahim Shah Road, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1555992336-03a23c7b20ee',
        'rating': 4.4,
      },
      {
        'id': 5,
        'name': 'Pizza Slice',
        'description': 'Pizza and fast food in Jahanian',
        'contact_number': '0308-4824792, 0311-4971155',
        'address':
            'Main Khanewall Highway Road, Infront of Qudas Masjid Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
        'rating': 4.0,
      },
      {
        'id': 6,
        'name': 'Nawab Hotel',
        'description':
            'Traditional Pakistani cuisine with biryani and karahi specialties',
        'contact_number': '0300-1234567',
        'address': 'Main Bazar, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1552566626-52f8b828add9',
        'rating': 4.1,
      },
      {
        'id': 7,
        'name': "Beba's Kitchen",
        'description':
            'Goodness in every munch. Specializes in pizzas, burgers, and rice dishes',
        'contact_number': '0311-4971155, 0303-4971155',
        'address':
            'Shop #97, Press Club Road, Near Gourmet Cola Agency, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1552566626-52f8b828add9',
        'rating': 4.2,
      },
      {
        'id': 8,
        'name': 'EatWay',
        'description': 'Wide variety of pizzas, fast food and deals',
        'contact_number': '0301-0800777, 0310-0800777',
        'address': 'Rehmat Villas, Phase 1, Canal Road, Jahanian',
        'image_url':
            'https://images.unsplash.com/photo-1552566626-52f8b828add9',
        'rating': 4.3,
      },
    ];
  }

  // Filter deals based on search text, favorite status, and selected restaurant
  List<Map<String, dynamic>> _filterDeals() {
    return _allDeals.where((deal) {
      // Filter by search text
      final matchesSearch = _searchController.text.isEmpty ||
          deal['title']
              .toString()
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          deal['description']
              .toString()
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());

      // Filter by restaurant
      final matchesRestaurant = _selectedRestaurant == 'All Restaurants' ||
          deal['restaurants']['name'] == _selectedRestaurant;

      // Filter by favorites
      final matchesFavorites =
          !_showOnlyFavorites || _favoriteDeals.contains(deal['id']);

      return matchesSearch && matchesRestaurant && matchesFavorites;
    }).toList();
  }

  void _selectRestaurant(String restaurant) {
    setState(() {
      _selectedRestaurant = restaurant;
    });
    _filterDeals();
  }

  Future<void> _toggleFavorite(int dealId) async {
    try {
      // Try to save to database if user is logged in
      bool isFavorite = false;
      try {
        isFavorite = await _databaseService.toggleFavorite(dealId);
      } catch (e) {
        // If database operation fails, continue with local storage only
        debugPrint('Database favorite toggle failed, using local storage: $e');
      }

      // Update local state and storage
      setState(() {
        if (_favoriteDeals.contains(dealId)) {
          _favoriteDeals.remove(dealId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Removed from favorites'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          _favoriteDeals.add(dealId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to favorites'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      });

      // Save to local storage
      await _saveFavoritesToLocal();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update favorites'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDealDetails(Map<String, dynamic> deal) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Deal image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: deal['image_url'] != null
                  ? Image.network(
                      deal['image_url'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.orange.withOpacity(0.1),
                      child: const Icon(
                        Icons.fastfood,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deal['title'] ?? 'Unnamed Deal',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'From: ${deal['restaurants']['name'] ?? 'Unknown Restaurant'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (deal['price'] != null)
                    Text(
                      'Price: Rs. ${deal['price'].toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (deal['discount_percentage'] != null)
                    Text(
                      'Discount: ${deal['discount_percentage']}% OFF',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (deal['description'] != null)
                    Text(
                      deal['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailsPage(
                              restaurantId: deal['restaurants']['id'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Contact Restaurant'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black,
              child: Row(
                children: [
                  const Text(
                    'Food Deals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      _showOnlyFavorites
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _showOnlyFavorites ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _showOnlyFavorites = !_showOnlyFavorites;
                        _filteredDeals = _filterDeals();
                      });
                    },
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _errorMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _loadData,
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        )
                      : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_filteredDeals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.no_meals,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No deals found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different filter',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _selectedRestaurant = 'All Restaurants';
                  _showOnlyFavorites = false;
                  _filteredDeals = _filterDeals();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header background with search
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.orange.shade900,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _filteredDeals = _filterDeals();
                    });
                  },
                  style: const TextStyle(
                      color: Colors.black), // FIXED: Text color to black
                  decoration: InputDecoration(
                    hintText: 'Search for deals...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              _filteredDeals = _filterDeals();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Restaurant Filter with horizontal scrolling
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Restaurants',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // View All button
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RestaurantDetailsPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.restaurant, color: Colors.white),
                        label: const Text(
                          'View All',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 50, // Increased height
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildRestaurantChip('All Restaurants'),
                        ..._restaurants.map((restaurant) =>
                            _buildRestaurantChip(restaurant['name'])),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Deals list with image assets instead of cards
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredDeals.length,
              itemBuilder: (context, index) {
                final deal = _filteredDeals[index];
                final bool isFavorite = _favoriteDeals.contains(deal['id']);

                return _buildDealImageCard(deal, isFavorite);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantChip(String restaurant) {
    final bool isSelected = _selectedRestaurant == restaurant;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          restaurant,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          _selectRestaurant(restaurant);
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.orange,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        elevation: isSelected ? 2 : 0,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
    );
  }

  Widget _buildDealImageCard(Map<String, dynamic> deal, bool isFavorite) {
    // Determine which image asset to use based on the restaurant name
    String assetImage = 'assets/images/default_deal.jpg';
    final restaurantName = (deal['restaurants'] as Map<String, dynamic>)['name']
        .toString()
        .toLowerCase();
    final int dealId = deal['id'] as int;

    // List of all deal images for this restaurant for fullscreen viewing
    final List<String> allDealImages = _getRestaurantDealImages(restaurantName);

    if (restaurantName.contains('meet n eat')) {
      assetImage = dealId % 2 == 0
          ? 'assets/images/meetneatdeal1.jpg'
          : 'assets/images/meetneatDeals2.jpg';
    } else if (restaurantName.contains('pizza slice')) {
      assetImage = dealId % 2 == 0
          ? 'assets/images/pizzaslice1.jpeg'
          : 'assets/images/pizzaslicedeals.jpg';
    } else if (restaurantName.contains('miran') ||
        restaurantName.contains('mfc')) {
      assetImage = dealId % 2 == 0
          ? 'assets/images/mfcdeals.jpg'
          : 'assets/images/mfcdeals2.jpg';
    } else if (restaurantName.contains('crust bros')) {
      assetImage = 'assets/images/restaurant1.jpg';
    } else if (restaurantName.contains('khana khazana')) {
      assetImage = 'assets/images/restaurant2.jpg';
    } else if (restaurantName.contains('nawab')) {
      assetImage = 'assets/images/nawab_hotel_jahanian.jpg';
    } else if (restaurantName.contains('beba')) {
      assetImage = 'assets/images/bebaskitchen.jpg';
    } else if (restaurantName.contains('eatway')) {
      assetImage = 'assets/images/eatway.jpg';
    }

    return GestureDetector(
      onTap: () {
        _showDealDetails(deal);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deal Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Image with tap handler for fullscreen
                  GestureDetector(
                    onTap: () {
                      _showDealFullscreen(allDealImages,
                          _getDealImageIndex(assetImage, allDealImages));
                    },
                    child: Image.asset(
                      assetImage,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey[300],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image_not_supported,
                                    size: 40, color: Colors.grey),
                                const SizedBox(height: 8),
                                Text(
                                  deal['title'] ?? 'Deal Image',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Overlay with deal details
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  deal['title'] ?? 'Deal',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                'Rs. ${deal['price']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            (deal['restaurants']
                                    as Map<String, dynamic>)['name'] ??
                                '',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  color: Colors.black,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        _toggleFavorite(deal['id']);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  // Fullscreen indicator
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get all deal images for a restaurant
  List<String> _getRestaurantDealImages(String restaurantName) {
    final List<String> images = [];

    if (restaurantName.contains('meet n eat')) {
      images.addAll([
        'assets/images/meetneatdeal1.jpg',
        'assets/images/meetneatDeals2.jpg',
      ]);
    } else if (restaurantName.contains('pizza slice')) {
      images.addAll([
        'assets/images/pizzaslice1.jpeg',
        'assets/images/pizzaslicedeals.jpg',
      ]);
    } else if (restaurantName.contains('miran') ||
        restaurantName.contains('mfc')) {
      images.addAll([
        'assets/images/mfcdeals.jpg',
        'assets/images/mfcdeals2.jpg',
      ]);
    } else if (restaurantName.contains('crust bros')) {
      images.add('assets/images/restaurant1.jpg');
    } else if (restaurantName.contains('khana khazana')) {
      images.add('assets/images/restaurant2.jpg');
    } else if (restaurantName.contains('nawab')) {
      images.add('assets/images/nawab_hotel_jahanian.jpg');
    } else if (restaurantName.contains('beba')) {
      images.add('assets/images/bebaskitchen.jpg');
    } else if (restaurantName.contains('eatway')) {
      images.addAll([
        'assets/images/eatway.jpg',
        'assets/images/eatway1.jpg',
        'assets/images/eatway2.jpg',
      ]);
    }

    // If no images found, add a default one
    if (images.isEmpty) {
      images.add('assets/images/default_deal.jpg');
    }

    return images;
  }

  // Get the index of the current deal image in the list of all deal images
  int _getDealImageIndex(String currentImage, List<String> allImages) {
    final index = allImages.indexOf(currentImage);
    return index >= 0 ? index : 0;
  }

  // Show fullscreen deal images
  void _showDealFullscreen(List<String> images, int initialIndex) {
    showDealFullscreen(
      context,
      images,
      initialIndex,
      'Deal Image',
    );
  }
}
