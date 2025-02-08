import 'package:flutter/material.dart';
import 'menu_gallery_view.dart';
import '../widgets/animated_filter_chip.dart';
import '../widgets/animated_menu_card.dart';
import '../widgets/restaurant_menu_gallery.dart';
import '../widgets/menu_image_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem {
  final String title;
  final List<String> images;
  final Color color;
  final List<String> categories;
  final List<String> searchTags;

  const MenuItem({
    required this.title,
    required this.images,
    required this.color,
    required this.categories,
    required this.searchTags,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final bool _showMoreOptions = false;
  final TextEditingController _searchController = TextEditingController();
  Color _allButtonColor = Colors.grey;
  Color _fastFoodButtonColor = Colors.grey;
  Color _desiFoodButtonColor = Colors.grey;
  Color _pizzaButtonColor = Colors.grey;
  Color _burgerButtonColor = Colors.grey;

  TextStyle _headerTextStyle = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle _subHeaderTextStyle = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.white,
  );

  TextStyle _buttonTextStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Color _headerGradientStart = Colors.orange.withOpacity(0.7);
  Color _headerGradientEnd = Colors.black.withOpacity(0.5);

  Color _buttonSelectedColor = Colors.orange;
  Color _buttonUnselectedColor = Colors.white;

  final List<MenuItem> allMenuItems = [
    MenuItem(
      title: 'Pizza Slice',
      images: [
        'assets/images/pizzaslice1.jpg',
        'assets/images/pizzaslice2.jpg'
      ],
      color: const Color(0xFFFF8C00),
      categories: ['Pizza'],
      searchTags: ['pizza slice', 'pizzas', 'fast food'],
    ),
    MenuItem(
      title: 'Khana Khazana',
      images: [
        'assets/images/khanakhazana1.jpg',
        'assets/images/khanakhazana2.jpg'
      ],
      color: const Color(0xFF4CAF50),
      categories: ['Desi'],
      searchTags: ['khana khazana', 'desi food'],
    ),
    MenuItem(
      title: 'Meet N Eat',
      images: ['assets/images/meetneat1.jpg', 'assets/images/meetneat2.jpg'],
      color: const Color(0xFF2196F3),
      categories: ['Fast Food'],
      searchTags: ['meet n eat', 'fast food'],
    ),
    MenuItem(
      title: 'Crust Bros Menu',
      images: ['assets/images/crustbros1.jpg', 'assets/images/CrustBros2.jpg'],
      color: const Color(0xFFFF8C00),
      categories: ['Pizza', 'Burger', 'Pasta'],
      searchTags: [
        'crust bros',
        'pizza',
        'burger',
        'pasta',
        'fries',
        'calzone',
        'chunks',
        'shawarma',
        'wraps',
        'mexican wraps',
        'wings',
        'special platter',
        'hot shots',
        'sandwiches',
        'fast food'
      ],
    ),
    MenuItem(
      title: 'Meeran Jee Restaurant Menu',
      images: ['assets/images/mfc.jpg', 'assets/images/mfc2.jpg'],
      color: const Color(0xFF2196F3),
      categories: ['Pizza', 'Burger'],
      searchTags: ['meeran jee', 'pizza', 'burger', 'fast food'],
    ),
    MenuItem(
      title: 'EatWay Menu',
      images: ['assets/images/eatway1.jpg', 'assets/images/eatway2.jpg'],
      color: const Color(0xFF4CAF50),
      categories: ['Pizza', 'Burger'],
      searchTags: ['eatway', 'pizza', 'burger', 'fast food'],
    ),
    MenuItem(
      title: 'Nawab Hotel Menu',
      images: [
        'assets/images/nawab.jpg',
        'assets/images/nawab1.jpg',
        'assets/images/nawab2.jpg',
        'assets/images/nawab3.jpg'
      ],
      color: const Color(0xFFE91E63),
      categories: ['Desi'],
      searchTags: [
        'nawab hotel',
        'desi food',
        'karhai',
        'chicken',
        'chinese',
        'pulao',
        'biryani',
        'rice',
        'soup',
        'bbq',
        'ice cream',
        'hot drinks',
        'traditional'
      ],
    ),
  ];

  List<MenuItem> get filteredMenuItems {
    if (_selectedCategory == 'All') {
      return allMenuItems;
    } else if (_selectedCategory == 'Fast Food') {
      return allMenuItems
          .where((item) =>
              item.title == 'Pizza Slice' ||
              item.title == 'Meet N Eat' ||
              item.title == 'Khana Khazana' ||
              item.title == 'EatWay' ||
              item.title == 'Meeran Jee Restaurant Menu' ||
              item.title == 'Crust Bros Menu')
          .toSet()
          .toList();
    } else if (_selectedCategory == 'Desi Food') {
      return allMenuItems
          .where((item) =>
              item.title == 'Nawab Hotel Menu' || item.title == 'Khana Khazana')
          .toSet()
          .toList();
    } else if (_selectedCategory == 'Pizza' || _selectedCategory == 'Burger') {
      return allMenuItems.toSet().toList();
    }
    return allMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Enhanced Header with Curved Bottom
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pizza_bg.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _headerGradientStart,
                        _headerGradientEnd,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, 60, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Customer!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.amberAccent,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Menus ',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text: 'of All\nrestaurants',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Enhanced Filter Buttons
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedCategory == 'All'
                          ? _buttonSelectedColor
                          : _buttonUnselectedColor,
                      foregroundColor: _selectedCategory == 'All'
                          ? Colors.white
                          : Colors.black87,
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                            color: Colors.orange.withOpacity(0.5), width: 1),
                      ),
                    ),
                    child: Text(
                      'All',
                      style: _buttonTextStyle,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'Fast Food';
                      });
                    },
                    icon: Image.asset(
                      'assets/images/pizza_icon.png',
                      height: 18,
                      width: 18,
                    ),
                    label: Text(
                      'Fast Food',
                      style: _buttonTextStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedCategory == 'Fast Food'
                          ? _buttonSelectedColor
                          : _buttonUnselectedColor,
                      foregroundColor: _selectedCategory == 'Fast Food'
                          ? Colors.white
                          : Colors.black87,
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                            color: Colors.orange.withOpacity(0.5), width: 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'Desi Food';
                      });
                    },
                    icon: Image.asset(
                      'assets/images/biryani_icon.png',
                      height: 18,
                      width: 18,
                    ),
                    label: Text(
                      'Desi Food',
                      style: _buttonTextStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedCategory == 'Desi Food'
                          ? _buttonSelectedColor
                          : _buttonUnselectedColor,
                      foregroundColor: _selectedCategory == 'Desi Food'
                          ? Colors.white
                          : Colors.black87,
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                            color: Colors.orange.withOpacity(0.5), width: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Restaurant Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: filteredMenuItems
                  .map((item) => _buildRestaurantCard(item))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(MenuItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                backgroundColor: Colors.black,
                body: MenuImageSlider(
                  images: item.images,
                  restaurantName: item.title.replaceAll(' Menu', ''),
                ),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      item.images[0],
                      fit: BoxFit.cover,
                    ),
                    // Cool gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.3),
                            item.color.withOpacity(0.5),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    // Plus button with gradient
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(), // Removing the + icon
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.replaceAll(' Menu', ''),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 248, 202, 20),
                        size: 16,
                      ),
                      Text(
                        item.title == 'Pizza Slice'
                            ? ' 4.6'
                            : item.title == 'Meet N Eat'
                                ? ' 4.7'
                                : item.title == 'Khana Khazana'
                                    ? ' 4.7'
                                    : item.title == 'Nawab Hotel Menu'
                                        ? ' 4.1'
                                        : item.title == 'EatWay Menu'
                                            ? ' 4.3'
                                            : item.title ==
                                                    'Meeran Jee Restaurant Menu'
                                                ? ' 4.2'
                                                : item.title ==
                                                        'Crust Bros Menu'
                                                    ? ' 4.3'
                                                    : ' 4.5',
                        style: TextStyle(
                          color: const Color.fromARGB(190, 117, 117, 117),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.location_on,
                          color: const Color.fromARGB(188, 117, 117, 117),
                          size: 16),
                      Expanded(
                        child: Text(
                          item.title == 'Crust Bros Menu'
                              ? 'Loha Bazar, Jahanian'
                              : item.title == 'EatWay Menu'
                                  ? 'Rehmat Villas, Phase 1, Canal Road, Jahanian'
                                  : item.title == 'Meeran Jee Restaurant Menu'
                                      ? 'Branch 1: Near Ice Factory Rahim Shah Road, Jahanian'
                                      : item.title == 'Nawab Hotel Menu'
                                          ? 'Bypass'
                                          : item.title == 'Pizza Slice'
                                              ? 'Main Khanewall Highway Road Infront of Qudas Masjid Jahanian'
                                              : item.title == 'Khana Khazana'
                                                  ? 'Main Super Highway Bahawal Pur Road Near Total Petrol Pump Jahanian'
                                                  : item.title == 'Meet N Eat'
                                                      ? 'Opposite Nadra Office, Multan Road, Jahanian'
                                                      : 'Bypass',
                          style: TextStyle(
                            color: const Color.fromARGB(181, 103, 102, 102),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
