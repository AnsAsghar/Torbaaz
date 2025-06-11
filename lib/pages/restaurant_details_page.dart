import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/database_service.dart';
import '../widgets/deal_fullscreen_viewer.dart';
import '../widgets/restaurant_menu_gallery.dart';
import '../models/restaurant_data_model.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int? restaurantId;

  const RestaurantDetailsPage({super.key, this.restaurantId});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  final _databaseService = DatabaseService();
  bool _isLoading = true;
  List<Map<String, dynamic>> _restaurants = [];
  Map<String, List<Map<String, dynamic>>> _restaurantDeals = {};
  Map<String, List<Map<String, dynamic>>> _restaurantMenuItems = {};
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Fetch all restaurants
      final restaurants = await _databaseService.getRestaurants();

      // Add Jahanian restaurants if few or no restaurants are available
      final enrichedRestaurants = _addJahanianRestaurants(restaurants);

      setState(() {
        _restaurants = enrichedRestaurants;
        _isLoading = false;
      });

      // Fetch details for all restaurants
      for (var restaurant in enrichedRestaurants) {
        await _fetchRestaurantDetails(restaurant['id'], restaurant['name']);
      }
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
      setState(() {
        _errorMessage = 'Error loading restaurants. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchRestaurantDetails(
      int restaurantId, String restaurantName) async {
    try {
      // Fetch deals for this restaurant
      final deals = await _databaseService.getDeals();
      List<Map<String, dynamic>> restaurantDeals = deals
          .where((deal) => deal['restaurants']['id'] == restaurantId)
          .toList();

      // Fetch menu items for this restaurant
      final menuItems = await _databaseService.getEatables();
      List<Map<String, dynamic>> restaurantMenuItems = menuItems
          .where((item) => item['restaurants']['id'] == restaurantId)
          .toList();

      // If no menu items found, add placeholder items based on restaurant name
      if (restaurantMenuItems.isEmpty) {
        restaurantMenuItems = _getMenuItemsFromDataset(restaurantName);
      }

      // If no deals found, add placeholder deals based on restaurant name
      if (restaurantDeals.isEmpty) {
        restaurantDeals = _getDealsFromDataset(restaurantName);
      }

      setState(() {
        _restaurantDeals[restaurantId.toString()] = restaurantDeals;
        _restaurantMenuItems[restaurantId.toString()] = restaurantMenuItems;
      });
    } catch (e) {
      debugPrint('Error fetching restaurant details: $e');
      // We'll show these errors only in the specific tabs
      setState(() {
        _restaurantMenuItems[restaurantId.toString()] =
            _getMenuItemsFromDataset(restaurantName);
        _restaurantDeals[restaurantId.toString()] =
            _getDealsFromDataset(restaurantName);
      });
    }
  }

  // Helper method to generate menu items based on restaurant name using dataset.txt
  List<Map<String, dynamic>> _getMenuItemsFromDataset(String restaurantName) {
    final List<Map<String, dynamic>> items = [];
    int itemId = 1;
    final lowerName = restaurantName.toLowerCase();

    // Find matching restaurant in allRestaurants
    final restaurantModel = allRestaurants.firstWhere(
      (r) =>
          r.name.toLowerCase().contains(lowerName) ||
          lowerName.contains(r.name.toLowerCase()),
      orElse: () => allRestaurants.first,
    );

    // Add menu items from restaurant model first
    for (var category in restaurantModel.menuCategories) {
      items.add({
        'id': itemId++,
        'name': category.name,
        'description': '${category.description} - Rs. ${category.price}',
        'category': 'Main Menu',
        'price': category.price,
        'image_url':
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
        'restaurants': {
          'id': int.parse(restaurantModel.id),
          'name': restaurantName
        },
      });
    }

    // Add items from dataset based on restaurant name
    if (lowerName.contains('meet n eat')) {
      // Meet N Eat menu items from dataset
      items.addAll([
        {
          'id': itemId++,
          'name': 'Oven Baked Wings',
          'description': '6Pcs Rs. 390/-, 12Pcs Rs. 750/-',
          'category': 'Appetizers',
          'price': 390,
          'image_url':
              'https://images.unsplash.com/photo-1608039755401-742074f0548d',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Crispy Zinger Burger',
          'description': 'Crispy chicken with mayo and lettuce in sesame bun',
          'category': 'Burgers',
          'price': 350,
          'image_url':
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Peri Peri Pizza',
          'description':
              'Small 6" - Rs. 500/-, Medium 9" - Rs. 950/-, Large 12" - Rs. 1200/-',
          'category': 'Pizzas',
          'price': 950,
          'image_url':
              'https://images.unsplash.com/photo-1593246049226-ded77bf90326',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Fettuccine Pasta',
          'description': 'Creamy pasta with special sauce',
          'category': 'Pasta',
          'price': 590,
          'image_url':
              'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('crust bros')) {
      // Crust Bros menu items from dataset
      items.addAll([
        {
          'id': itemId++,
          'name': 'Special Platter',
          'description':
              '4 Pcs Spin Roll, 6 Pcs Wings, Fries & Dip Sauce - Rs. 1050',
          'category': 'Platters',
          'price': 1050,
          'image_url':
              'https://images.unsplash.com/photo-1585511545568-e64b2b203441',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Cheese Lover Pizza',
          'description': 'Medium: Rs. 1099, Large: Rs. 1399',
          'category': 'Regular Pizzas',
          'price': 1099,
          'image_url':
              'https://images.unsplash.com/photo-1594007654729-407eedc4fe24',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Zinger Burger',
          'description': 'Rs. 399',
          'category': 'Burgers',
          'price': 399,
          'image_url':
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('khana khazana')) {
      // Khana Khazana menu items from dataset
      items.addAll([
        {
          'id': itemId++,
          'name': 'KK Special Chicken Handi',
          'description': 'Rs. 850/1450',
          'category': 'KK Chicken Handi',
          'price': 850,
          'image_url':
              'https://images.unsplash.com/photo-1589302168068-964664d93dc0',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'KK Special Mutton Biryani',
          'description': 'Rs. 500/950',
          'category': 'KK Biryani',
          'price': 500,
          'image_url':
              'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Special Family Deal',
          'description':
              'Mutton Karahi, Shashlic with Rice, Half Chicken Handi and more',
          'category': 'Special Deals',
          'price': 6699,
          'image_url':
              'https://images.unsplash.com/photo-1547496502-affa22d38842',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('miran') || lowerName.contains('mfc')) {
      // MFC menu items from dataset
      items.addAll([
        {
          'id': itemId++,
          'name': 'Vege Lover Pizza',
          'description': 'Rs. 520',
          'category': 'Standard Pizza',
          'price': 520,
          'image_url':
              'https://images.unsplash.com/photo-1571047399553-603e2138b646',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Chicken Tikka Pizza',
          'description': 'Rs. 1000',
          'category': 'Standard Pizza',
          'price': 1000,
          'image_url':
              'https://images.unsplash.com/photo-1513104890138-7c749659a591',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Deal 1',
          'description': '1 Chicken Burger, 1500ml Drink',
          'category': 'Deals',
          'price': 390,
          'image_url':
              'https://images.unsplash.com/photo-1610614819513-58e34989e371',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('pizza slice')) {
      // Pizza Slice menu items from dataset
      items.addAll([
        {
          'id': itemId++,
          'name': 'Achari Pizza',
          'description': 'Small: Rs. 500, Medium: Rs. 950',
          'category': 'Pizza',
          'price': 500,
          'image_url':
              'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Zinger Burger',
          'description': 'Rs. 330',
          'category': 'Burgers',
          'price': 330,
          'image_url':
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': itemId++,
          'name': 'Deal 1',
          'description': '5 Zinger Burger, 1.5 Ltr. Drink',
          'category': 'Deals',
          'price': 1700,
          'image_url':
              'https://images.unsplash.com/photo-1610614819513-58e34989e371',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    }

    return items;
  }

  // Helper method to generate deals based on restaurant name using dataset.txt
  List<Map<String, dynamic>> _getDealsFromDataset(String restaurantName) {
    final List<Map<String, dynamic>> deals = [];
    int dealId = 1;
    final lowerName = restaurantName.toLowerCase();

    // Find matching restaurant in allRestaurants
    final restaurantModel = allRestaurants.firstWhere(
      (r) =>
          r.name.toLowerCase().contains(lowerName) ||
          lowerName.contains(r.name.toLowerCase()),
      orElse: () => allRestaurants.first,
    );

    // Add deals based on restaurant name from dataset.txt
    if (lowerName.contains('meet n eat')) {
      deals.addAll([
        {
          'id': dealId++,
          'title': 'Deal 1',
          'description': '1 Zinger Burger, Small Fries, 350ml Soft Drink',
          'price': 600,
          'is_featured': true,
          'discount_percentage': 15,
          'image_url':
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'Deal 2',
          'description': '1 Mighty Burger, Regular Fries, 350ml Soft Drink',
          'price': 800,
          'is_featured': false,
          'discount_percentage': 10,
          'image_url':
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'Pizza Deal 1',
          'description': '1 Medium Pizza, Small Fries, 500ml Soft Drink',
          'price': 1250,
          'is_featured': true,
          'discount_percentage': 20,
          'image_url':
              'https://images.unsplash.com/photo-1593246049226-ded77bf90326',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('crust bros')) {
      deals.addAll([
        {
          'id': dealId++,
          'title': 'Regular Pizzas Deal',
          'description':
              '6 inches - Rs. 599, 9 inches - Rs. 1099, 12 inches - Rs. 1399',
          'price': 599,
          'is_featured': true,
          'discount_percentage': 15,
          'image_url':
              'https://images.unsplash.com/photo-1594007654729-407eedc4fe24',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'Special Platter',
          'description': '4 Pcs Spin Roll, 6 Pcs Wings, Fries & Dip Sauce',
          'price': 1050,
          'is_featured': true,
          'discount_percentage': 10,
          'image_url':
              'https://images.unsplash.com/photo-1585511545568-e64b2b203441',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('khana khazana')) {
      deals.addAll([
        {
          'id': dealId++,
          'title': 'Special Family Deal',
          'description':
              '1 Mutton Karahi, 1 Shashlic with Rice, Half Chicken Handi, Tikka Boti, and more',
          'price': 6699,
          'is_featured': true,
          'discount_percentage': 20,
          'image_url':
              'https://images.unsplash.com/photo-1547496502-affa22d38842',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'BBQ Platter 2 Person',
          'description':
              '1/2 Beef Karahi, 4 Pc Malai Boti, 5 Pc Wings, 1 Garlic Nan',
          'price': 1850,
          'is_featured': false,
          'discount_percentage': 5,
          'image_url':
              'https://images.unsplash.com/photo-1551326844-4df70f78d0e9',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('miran') || lowerName.contains('mfc')) {
      deals.addAll([
        {
          'id': dealId++,
          'title': 'Deal 1',
          'description': '1 Chicken Burger, 1500ml Drink',
          'price': 390,
          'is_featured': true,
          'discount_percentage': 15,
          'image_url':
              'https://images.unsplash.com/photo-1610614819513-58e34989e371',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'Deal 5',
          'description': '1 Chicken Burger, 1 Small Fries, 1500ml Drink',
          'price': 620,
          'is_featured': false,
          'discount_percentage': 10,
          'image_url':
              'https://images.unsplash.com/photo-1610614819513-58e34989e371',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    } else if (lowerName.contains('pizza slice')) {
      deals.addAll([
        {
          'id': dealId++,
          'title': 'Deal 1',
          'description': '5 Zinger Burger, 1.5 Ltr. Drink',
          'price': 1700,
          'is_featured': true,
          'discount_percentage': 15,
          'image_url':
              'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
        {
          'id': dealId++,
          'title': 'Deal 3',
          'description': '1 Small Pizza, 1 Zinger Burger, 1 Reg. Drink',
          'price': 1200,
          'is_featured': false,
          'discount_percentage': 10,
          'image_url':
              'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47',
          'restaurants': {
            'id': int.parse(restaurantModel.id),
            'name': restaurantName
          },
        },
      ]);
    }

    return deals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Restaurants Guide',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : _restaurants.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.restaurant,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'No restaurants available',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please check back later',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : _buildAllRestaurantsView(),
    );
  }

  Widget _buildAllRestaurantsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = _restaurants[index];
        return _buildRestaurantCard(restaurant);
      },
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    // Find restaurant in allRestaurants model if possible
    final String restaurantName = restaurant['name'].toString();
    final lowerName = restaurantName.toLowerCase();

    // Try to find a matching restaurant in our model
    final restaurantModel = allRestaurants.firstWhere(
      (r) =>
          r.name.toLowerCase().contains(lowerName) ||
          lowerName.contains(r.name.toLowerCase()),
      orElse: () => allRestaurants.first,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Restaurant Image with gradient overlay
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // Restaurant Image
                Image.asset(
                  restaurantModel.imageAsset.isNotEmpty
                      ? restaurantModel.imageAsset
                      : 'assets/images/restaurant1.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant,
                          size: 80, color: Colors.grey),
                    );
                  },
                ),
                // Gradient overlay
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Restaurant name and rating
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Rating stars
                          ...List.generate(
                            (restaurant['rating'] as num? ??
                                    restaurantModel.basicInfo.googleRating ??
                                    4)
                                .floor(),
                            (index) => const Icon(Icons.star,
                                color: Colors.amber, size: 20),
                          ),
                          const SizedBox(width: 8),
                          // Rating number
                          Text(
                            '${restaurant['rating'] ?? restaurantModel.basicInfo.googleRating ?? 4.0}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Restaurant Details Tabs
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Info'),
                    Tab(text: 'Menu'),
                    Tab(text: 'Deals'),
                  ],
                ),
                SizedBox(
                  height: 400, // Fixed height for tab content
                  child: TabBarView(
                    children: [
                      // Info Tab
                      _buildInfoTab(restaurant, restaurantModel),

                      // Menu Tab
                      _buildMenuTab(restaurant, restaurantModel),

                      // Deals Tab
                      _buildDealsTab(restaurant, restaurantModel),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Action Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final address = restaurant['address'] ??
                          restaurantModel.contactDetails.address;
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showContactOptions(restaurant, restaurantModel);
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTab(
      Map<String, dynamic> restaurant, RestaurantDataModel restaurantModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Section
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    restaurant['description'] ??
                        'Established in ${restaurantModel.basicInfo.established ?? "recent years"}, ${restaurantModel.basicInfo.fullName} is a ${restaurantModel.basicInfo.type} restaurant offering a variety of delicious menu items.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                  if (restaurant['additional_info'] != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      restaurant['additional_info'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Contact Information Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.contact_phone, color: Colors.orange, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Address
                  _buildInfoRow(
                    icon: Icons.location_on,
                    title: 'Address',
                    value: restaurant['address'] ??
                        restaurantModel.contactDetails.address,
                  ),

                  // Phone
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: restaurant['contact_number'] ??
                        restaurantModel.contactDetails.phone,
                    isPhone: true,
                  ),

                  // Opening Hours
                  if (restaurant['opening_hours'] != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.access_time,
                      title: 'Opening Hours',
                      value: restaurant['opening_hours'],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isPhone = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              isPhone
                  ? GestureDetector(
                      onTap: () {
                        // Launch phone call
                        launchUrl(Uri.parse('tel:$value'));
                      },
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTab(
      Map<String, dynamic> restaurant, RestaurantDataModel restaurantModel) {
    // Get menu items for this restaurant
    final restaurantId = restaurant['id'].toString();
    final menuItems = _restaurantMenuItems[restaurantId] ?? [];

    // Check if there are menu images available
    final hasMenuImages = restaurantModel.menuImages.isNotEmpty;

    // Group menu items by category
    final Map<String, List<Map<String, dynamic>>> categorizedItems = {};
    for (var item in menuItems) {
      final category = item['category'] ?? 'Uncategorized';
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(item);
    }

    return Column(
      children: [
        // Menu Images Button
        if (hasMenuImages)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantMenuGallery(
                      restaurantName: restaurant['name'],
                      menuImages: restaurantModel.menuImages,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.menu_book),
              label: const Text('View Menu Images'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ),

        // Menu Items List
        Expanded(
          child: menuItems.isEmpty
              ? Center(
                  child: Text(
                    'No menu items available for ${restaurant['name']}',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (var category in categorizedItems.keys)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Category Items
                          ...categorizedItems[category]!.map((item) => Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(Icons.restaurant_menu,
                                        color: Colors.orange),
                                  ),
                                  title: Text(
                                    item['name'] ?? 'Menu Item',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(item['description'] ?? ''),
                                  trailing: Text(
                                    'Rs. ${item['price']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )),

                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildDealsTab(
      Map<String, dynamic> restaurant, RestaurantDataModel restaurantModel) {
    final restaurantId = restaurant['id'].toString();
    final deals = _restaurantDeals[restaurantId] ?? [];

    // Check if there are deal images available
    final hasDealImages = restaurantModel.dealImages.isNotEmpty;

    return Column(
      children: [
        // Deal Images Button
        if (hasDealImages)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                _showDealFullscreen(
                    restaurantModel.dealImages, 0, restaurant['name']);
              },
              icon: const Icon(Icons.image),
              label: const Text('View Deal Images'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ),

        // Deals List
        Expanded(
          child: deals.isEmpty
              ? Center(
                  child: Text(
                    'No deals available for ${restaurant['name']}',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: deals.length,
                  itemBuilder: (context, index) {
                    final deal = deals[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  deal['title'] ?? 'Special Deal',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Rs. ${deal['price']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              deal['description'] ?? 'Special promotional deal',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                if (deal['discount_percentage'] != null)
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${deal['discount_percentage']}% OFF',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (deal['is_featured'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'FEATURED',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showDealFullscreen(
      List<String> images, int initialIndex, String restaurantName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DealFullscreenViewer(
          images: images,
          initialIndex: initialIndex,
          title: '$restaurantName Deal',
        ),
      ),
    );
  }

  void _showContactOptions(
      Map<String, dynamic> restaurant, RestaurantDataModel restaurantModel) {
    final phoneNumber = restaurant['contact_number']?.toString() ??
        restaurantModel.contactDetails.phone;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Contact Restaurant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Restaurant: ${restaurant['name']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (phoneNumber.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Phone: $phoneNumber',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      final Uri phoneUri = Uri.parse('tel:$phoneNumber');
                      try {
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch phone app'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error launching phone: $e'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      // Extract first phone number if multiple are present
                      final String firstPhone =
                          phoneNumber.split(',').first.trim();
                      final Uri whatsappUri = Uri.parse(
                        'https://wa.me/92${firstPhone.replaceAll(RegExp(r'[^\d]'), '')}',
                      );
                      try {
                        if (await canLaunchUrl(whatsappUri)) {
                          await launchUrl(whatsappUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch WhatsApp'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error launching WhatsApp: $e'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to add Jahanian restaurants from local data
  List<Map<String, dynamic>> _addJahanianRestaurants(
      List<Map<String, dynamic>> existingRestaurants) {
    // Create a copy of existing restaurants
    final List<Map<String, dynamic>> enrichedList =
        List.from(existingRestaurants);

    // Get the highest existing ID to ensure unique IDs for new restaurants
    int nextId = 1;
    if (enrichedList.isNotEmpty) {
      nextId = enrichedList
              .map((r) => r['id'] as int)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }

    // Convert RestaurantDataModel to Map format for consistency
    for (var restaurant in allRestaurants) {
      if (!enrichedList.any((r) =>
          r['name'].toString().toLowerCase() ==
          restaurant.name.toLowerCase())) {
        enrichedList.add({
          'id': nextId++,
          'name': restaurant.name,
          'description':
              'Established in ${restaurant.basicInfo.established ?? "recent years"}, ${restaurant.basicInfo.fullName} is a ${restaurant.basicInfo.type} restaurant offering a variety of delicious menu items.',
          'address': restaurant.contactDetails.address,
          'contact_number': restaurant.contactDetails.phone,
          'opening_hours': '11:00 AM - 11:00 PM',
          'rating': restaurant.basicInfo.googleRating ?? 4.0,
          'image_url': null,
          'additional_info': 'Fast Delivery. Online Payment Options Available.',
        });
      }
    }

    return enrichedList;
  }
}
