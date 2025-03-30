import 'package:flutter/material.dart';
import 'restaurant_details_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FoodDealsPage extends StatefulWidget {
  const FoodDealsPage({super.key});

  @override
  State<FoodDealsPage> createState() => _FoodDealsPageState();
}

class _FoodDealsPageState extends State<FoodDealsPage>
    with SingleTickerProviderStateMixin {
  final Set<String> _favoriteItems = {};
  late TabController _tabController;
  final List<String> _restaurants = [
    'All Deals',
    'Favorites',
    'Pizza Slice',
    'Meet N Eat',
    'Meera Jee',
    'Eat Way',
  ];

  // Deal images for each restaurant
  final Map<String, List<DealItem>> _restaurantDeals = {
    'All Deals': [],
    'Favorites': [],
    'Pizza Slice': [],
    'Meet N Eat': [],
    'Meera Jee': [],
    'Eat Way': [],
  };

  @override
  void initState() {
    super.initState();
    _initializeDeals();
    _tabController = TabController(length: _restaurants.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeDeals() {
    // Initialize deal items
    _restaurantDeals['All Deals'] = [
      DealItem(
        title: 'EatWay Special Deal 1',
        description: 'Enjoy a delicious meal with our special offer!',
        imagePath: 'assets/images/eatwayDeal1.jpg',
        restaurant: 'Eat Way',
      ),
      DealItem(
        title: 'EatWay Special Deal 2',
        description: 'Enjoy our special deal',
        imagePath: 'assets/images/eatwayDeal2.jpg',
        restaurant: 'Eat Way',
      ),
      DealItem(
        title: 'Meet N Eat Deal 1',
        description: 'Enjoy our special deal',
        imagePath: 'assets/images/meetneatdeal1.jpg',
        restaurant: 'Meet N Eat',
      ),
      DealItem(
        title: 'Meet N Eat Deal 2',
        description: 'Enjoy our special deal',
        imagePath: 'assets/images/meetneatDeals2.jpg',
        restaurant: 'Meet N Eat',
      ),
      DealItem(
        title: 'Meera Jee Deal',
        description: 'Enjoy our special deal!',
        imagePath: 'assets/images/mfcdeals.jpg',
        restaurant: 'Meera Jee',
      ),
      DealItem(
        title: 'Meera Jee Deal 2',
        description: 'Enjoy our special deal',
        imagePath: 'assets/images/mfcdeals2.jpg',
        restaurant: 'Meera Jee',
      ),
      DealItem(
        title: 'Pizza Slice Deal',
        description: 'Enjoy our special deal!',
        imagePath: 'assets/images/pizzaslicedeals.jpg',
        restaurant: 'Pizza Slice',
      ),
    ];

    // Fill restaurant-specific deals
    for (var deal in _restaurantDeals['All Deals']!) {
      _restaurantDeals[deal.restaurant]?.add(deal);
    }
  }

  void _updateFavorites() {
    _restaurantDeals['Favorites'] = _restaurantDeals['All Deals']!
        .where((deal) => _favoriteItems.contains(deal.title))
        .toList();
  }

  void _toggleFavorite(String title) {
    setState(() {
      if (_favoriteItems.contains(title)) {
        _favoriteItems.remove(title);
      } else {
        _favoriteItems.add(title);
      }
      _updateFavorites();
    });
  }

  void _showFullScreenImage(BuildContext context, String imagePath,
      int initialIndex, List<DealItem> deals) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(deals[initialIndex].title,
                style: TextStyle(color: Colors.white)),
          ),
          body: PhotoViewGallery.builder(
            scrollPhysics: BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(deals[index].imagePath),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            itemCount: deals.length,
            backgroundDecoration: BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
            onPageChanged: (index) {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header section with pizza image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pizzaslicedeals.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Deals',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Taste the delicious food of Jahanian',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab bar for restaurant selection
          Container(
            color: Colors.red.shade800,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              padding: EdgeInsets.symmetric(horizontal: 8),
              tabs: _restaurants
                  .map((restaurant) => Tab(
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (restaurant == 'Favorites')
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.favorite, size: 16),
                              ),
                            Text(
                              restaurant,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Tab view content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _restaurants.map((restaurant) {
                List<DealItem> deals = _restaurantDeals[restaurant] ?? [];

                return deals.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              restaurant == 'Favorites'
                                  ? Icons.favorite_border
                                  : Icons.no_meals,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              restaurant == 'Favorites'
                                  ? 'No favorite deals yet'
                                  : 'No deals available for $restaurant',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            if (restaurant == 'Favorites')
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Tap the heart icon on any deal to add it to favorites',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(12),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: deals.length,
                          itemBuilder: (context, index) {
                            return _buildDealCard(deals[index], index, deals);
                          },
                        ),
                      );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(DealItem deal, int index, List<DealItem> deals) {
    bool isFavorite = _favoriteItems.contains(deal.title);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _showFullScreenImage(context, deal.imagePath, index, deals);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Hero(
                    tag: '${deal.imagePath}_$index',
                    child: Image.asset(
                      deal.imagePath,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Restaurant badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    deal.restaurant,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
                    ),
                    constraints: BoxConstraints.tight(Size(32, 32)),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _toggleFavorite(deal.title);
                    },
                  ),
                ),
              ),
            ],
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  deal.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailsPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(120, 30),
                    ),
                    child: Text('Order Now'),
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

// Simple class to hold deal information
class DealItem {
  final String title;
  final String description;
  final String imagePath;
  final String restaurant;

  DealItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.restaurant,
  });
}
