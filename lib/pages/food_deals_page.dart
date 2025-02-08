import 'package:flutter/material.dart';
import 'restaurant_details_page.dart'; // Ensure this import is added
// import 'favorites_page.dart'; // Removed this import

class FoodDealsPage extends StatefulWidget {
  const FoodDealsPage({super.key});

  @override
  State<FoodDealsPage> createState() => _FoodDealsPageState();
}

class _FoodDealsPageState extends State<FoodDealsPage> {
  // Remove the field since it's not being used.
  final TextEditingController _searchController = TextEditingController();
  List<MenuItem> _allItems = [];
  final Set<String> _favoriteItems = {};

  @override
  void initState() {
    super.initState();
    _initializeItems();
  }

  void _initializeItems() {
    _allItems = [
      // Crust Bros Items
      MenuItem(
        name: 'Zinger Burger',
        description: 'Crispy zinger fillet with mayo, lettuce, and sesame bun',
        price: 399,
        keywords: [
          'crispy',
          'zinger',
          'mayo',
          'lettuce',
          'sesame bun',
          'burger'
        ],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Chicken Grill Burger',
        description: 'Two grill fillets with signature sauce and lettuce',
        price: 649,
        keywords: ['grill fillet', 'signature sauce', 'lettuce', 'burger'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Tower Burger',
        description:
            'Crispy zinger fillet with chicken patty and signature mayo',
        price: 599,
        keywords: [
          'crispy zinger',
          'chicken patty',
          'signature mayo',
          'lettuce',
          'burger'
        ],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Mighty Burger',
        description: 'Special mighty burger with signature sauce',
        price: 649,
        keywords: ['mighty', 'burger'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Spicy Burger',
        description: 'Spicy chicken burger with special sauce',
        price: 299,
        keywords: ['spicy', 'burger'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Chicken Burger',
        description: 'Classic chicken burger',
        price: 299,
        keywords: ['chicken', 'burger'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Creamy Pizza',
        description: 'Chicken, cheese, sweet corn, olives, and special sauce',
        price: 649,
        keywords: [
          'chicken',
          'cheese',
          'sweet corn',
          'olives',
          'sauce',
          'pizza'
        ],
        hasVariants: true,
        variants: ['Small: 649', 'Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Shahi Pizza',
        description: 'Chicken, sausages, olives, capsicum, and onion',
        price: 649,
        keywords: [
          'chicken',
          'sausages',
          'olives',
          'capsicum',
          'onion',
          'pizza'
        ],
        hasVariants: true,
        variants: ['Small: 649', 'Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Crown Crust Pizza',
        description: 'Chicken, cheese, capsicum, onion, sauce',
        price: 1299,
        keywords: ['chicken', 'cheese', 'capsicum', 'onion', 'sauce', 'pizza'],
        hasVariants: true,
        variants: ['Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Special Pizza',
        description: 'Chicken, capsicum, onion, special sauce',
        price: 1299,
        keywords: ['chicken', 'capsicum', 'onion', 'special sauce', 'pizza'],
        hasVariants: true,
        variants: ['Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Deep Pan Pizza',
        description: 'Chicken, cheese, olives',
        price: 1299,
        keywords: ['chicken', 'cheese', 'olives', 'pizza'],
        hasVariants: true,
        variants: ['Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),
      MenuItem(
        name: 'Cheesy Pizza',
        description: 'Chicken, cheese, olives, sauce',
        price: 1299,
        keywords: ['chicken', 'cheese', 'olives', 'sauce', 'pizza'],
        hasVariants: true,
        variants: ['Medium: 1299', 'Large: 1649'],
        restaurant: 'Crust Bros',
      ),

      // Nawab Hotel Items
      MenuItem(
        name: 'Royal Special Chicken',
        description: 'Signature royal special chicken preparation',
        price: 700,
        keywords: ['royal', 'special', 'chicken', 'chinese'],
        restaurant: 'Nawab Hotel',
      ),
      MenuItem(
        name: 'Chicken Chilli Dry',
        description: 'Spicy dry chicken with bell peppers',
        price: 650,
        keywords: ['chilli', 'dry', 'chicken', 'spicy', 'chinese'],
        restaurant: 'Nawab Hotel',
      ),
      MenuItem(
        name: 'Royal Special Rice',
        description: 'Signature royal special fried rice',
        price: 700,
        keywords: ['royal', 'special', 'rice', 'fried rice'],
        restaurant: 'Nawab Hotel',
      ),
      MenuItem(
        name: 'Royal Special Beef Biryani',
        description: 'Special beef biryani with aromatic rice',
        price: 650,
        keywords: ['royal', 'special', 'beef', 'biryani'],
        hasVariants: true,
        variants: ['Full: 650', 'Half: 350'],
        restaurant: 'Nawab Hotel',
      ),
      MenuItem(
        name: 'Murgh Dum Biryani',
        description: 'Traditional chicken dum biryani',
        price: 500,
        keywords: ['murgh', 'chicken', 'dum', 'biryani'],
        hasVariants: true,
        variants: ['Full: 500', 'Half: 300'],
        restaurant: 'Nawab Hotel',
      ),
    ];
    _filterItems();
  }

  void _filterItems() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Deals'),
        backgroundColor: Colors.black, // Set AppBar color to black
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade600,
              Colors.red.shade500,
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.5, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    right: -20,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/pizzaBG.png',
                      height: MediaQuery.of(context).size.height * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Customer',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Taste the delicious food items of Jahanian',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            height: 1.2,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Adding food deals below the header
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  _buildFoodDealCard(
                      'assets/images/eatwayDeal1.jpg',
                      'EatWay Special Deal 1',
                      'Enjoy a delicious meal with our special offer!'),
                  _buildFoodDealCard('assets/images/eatwayDeal2.jpg',
                      'EatWay Special Deal 2', 'Enjoy our special deal'),
                  _buildFoodDealCard('assets/images/meetneatdeal1.jpg',
                      'Meet N Eat Deal 1', 'Enjoy our special deal'),
                  _buildFoodDealCard('assets/images/meetneatDeals2.jpg',
                      'Meet N Eat Deal 2', 'Enjoy our special deal'),
                  _buildFoodDealCard('assets/images/mfcdeals.jpg',
                      'Meera Jee Deal', 'Enjoy our special deal!'),
                  _buildFoodDealCard('assets/images/mfcdeals2.jpg',
                      'Meera Jee Deal', 'Enjoy our special deal'),
                  _buildFoodDealCard('assets/images/pizzaslicedeals.jpg',
                      'Pizza Slice Deal', 'Enjoy our special deal!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodDealCard(
      String imagePath, String title, String description) {
    bool isFavorite = _favoriteItems.contains(title);
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.redAccent)),
                SizedBox(height: 6),
                Text(description, style: TextStyle(color: Colors.grey[700])),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            _favoriteItems.remove(title);
                          } else {
                            _favoriteItems.add(title);
                          }
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantDetailsPage()), // Navigate to Restaurant Details Page
                        );
                      },
                      child: Text('Order Now',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Changed to orange
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final double price;
  final List<String> keywords;
  final bool hasVariants;
  final List<String>? variants;
  final String? restaurant;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    this.keywords = const [],
    this.hasVariants = false,
    this.variants,
    this.restaurant,
  });

  bool matchesSearch(String query) {
    query = query.toLowerCase();
    return name.toLowerCase().contains(query) ||
        description.toLowerCase().contains(query) ||
        keywords.any((keyword) => keyword.toLowerCase().contains(query)) ||
        (restaurant?.toLowerCase().contains(query) ?? false) ||
        price.toString().contains(query);
  }
}
