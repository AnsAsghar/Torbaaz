import 'package:flutter/material.dart';

class AIAssistantPage extends StatefulWidget {
  const AIAssistantPage({super.key});

  @override
  State<AIAssistantPage> createState() => _AIAssistantPageState();
}

class _AIAssistantPageState extends State<AIAssistantPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  List<String> previousQuestions = [];

  // Welcome message for the AI Assistant
  final String welcomeMessage = '''
🍽️ Welcome to Jahanian Food Explorer Bot! 🍔

Here's what you can ask me:

📋 Food Categories:
• "Show me all pizza options"
• "What burgers do you have?"
• "Tell me about shawarma deals"
• "Show pasta menu"
• "List all wraps"

🏪 Restaurant Info:
• "Tell me about Meet N Eat"
• "Show Pizza Slice menu"
• "What's special at MFC?"
• "Show Crust Bros contact"

💰 Deals & Prices:
• "Family deals available"
• "Best deals under 1000"

⭐ Ratings & Reviews:
• "Best rated restaurants"
• "Top rated pizzas"
• "Most popular items"

📍 Quick Facts:
• 6 Premium Restaurants
• 4.1 - 4.7 Star Ratings


Try asking any of these questions or explore our delicious menu! 😋
''';

  // Adding keyword triggers for food category responses
  List<String> pizzaKeywords = [
    'pizza',
    'Pizza',
    'pizzas',
    'peri peri pizza',
    'chicken supreme pizza',
    'cheese lover pizza',
    'malai boti pizza',
    'extreme pizza',
    'crust bros pizza',
    'pizza slice',
    'large pizza',
    'medium pizza',
    'small pizza',
    'pizza prices'
  ];
  List<String> burgerKeywords = [
    'burger',
    'burgers',
    'crispy zinger',
    'mighty zinger',
    'patty burger',
    'meet n eat special beef burger',
    'classic beef burger',
    'smoked beef burger',
    'zinger stacker'
  ];
  List<String> friesKeywords = [
    'fries',
    'french fries',
    'loaded fries',
    'pizza fries',
    'garlic mayo fries'
  ];
  List<String> wrapsKeywords = [
    'wraps',
    'wrap',
    'crispy wrap',
    'kababish wrap',
    'cheetos wrap',
    'meet n eat special wrap'
  ];
  List<String> mainCourseKeywords = [
    'biryani',
    'karahi',
    'chicken handi',
    'mutton karahi',
    'beef nihari',
    'nihari',
    'curry',
    'chicken korma'
  ];
  List<String> pastaKeywords = [
    'pasta',
    'fettuccine pasta',
    'flaming pasta',
    'fajita pasta',
    'crunchy pasta',
    'cheese pasta',
    'arabic pasta',
    'peri peri pasta',
    'white sauce pasta',
    'lasagna'
  ];
  List<String> wingsKeywords = [
    'wings',
    'oven baked wings',
    'fried wings',
    'crispy wings',
    'juicy wings',
    'bbq wings',
    'hot wings',
    'creamy baked wings',
    'mayo wings',
    'honey wings'
  ];
  List<String> nuggetsKeywords = [
    'nuggets',
    'chicken nuggets',
    'hot shots',
    'crunchy hot shots',
    'crispy nuggets'
  ];
  List<String> sandwichKeywords = [
    'sandwich',
    'club sandwich',
    'grilled chicken sandwich',
    'beef grilled sandwich',
    'grilled tikka sandwich',
    'meet n eat special sandwich',
    'mexican sandwich',
    'tikka sandwich',
    'bbq sandwich',
    'malai boti sandwich',
    'arabic sandwich'
  ];
  List<String> grilledKeywords = [
    'grilled',
    'mushroom steak',
    'jalapeno steak',
    'tarragon steak',
    'black pepper steak',
    'mexican steak',
    'classic grilled chicken burger',
    'smoked grilled chicken burger',
    'meet n eat special grilled burger'
  ];
  List<String> khanaKhazanaTandoorKeywords = [
    'khana khazana tandoor',
    'tandoor contact',
    'tandoor location',
    'tandoor details'
  ];
  List<String> dessertKeywords = [
    'desserts',
    'fruit trifle',
    'gajar halwa',
    'brownie',
    'hot gulab jamun',
    'labe sheere',
    'sizzling brownie'
  ];
  List<String> beverageKeywords = [
    'drinks',
    'soft drink',
    'water',
    'green tea',
    'chai',
    'doodh pati',
    'kashmiri chai',
    'fresh lime',
    'sting',
    'mineral water'
  ];
  List<String> bbqKeywords = [
    'bbq',
    'malai boti',
    'tikka boti',
    'reshmi kabab',
    'gola kabab',
    'green boti',
    'afghani boti',
    'qalmi tikka',
    'bbq leg piece'
  ];
  List<String> chineseKeywords = [
    'chowmein',
    'chinese',
    'kk special rice',
    'fried rice',
    'garlic rice',
    'plain rice',
    'vegetable rice',
    'american chopsuey',
    'kk special chopsuey'
  ];
  List<String> appetizerKeywords = [
    'appetizers',
    'chicken pakora',
    'crispy wings',
    'dhaka chicken',
    'sousey chicken',
    'fish crackers',
    'spin roll',
    'calzone chunks',
    'cheese sticks',
    'kabab bites',
    'arabic roll'
  ];
  List<String> sidesKeywords = [
    'sides',
    'garlic bread',
    'cheesy sticks',
    'mozzarella sticks',
    'chicken wings',
    'wings'
  ];
  List<String> dessertsKeywords = [
    'dessert',
    'gulab jamun',
    'rasmalai',
    'kheer',
    'sweets'
  ];
  List<String> drinksKeywords = [
    'drinks',
    'drink',
    'soft drinks',
    'soda',
    'juice',
    'fresh juice',
    'iced coffee',
    'cold coffee',
    'milkshake'
  ];
  List<String> generalFoodKeywords = [
    'food',
    'cuisine',
    'dish',
    'meal',
    'recipe',
    'ingredient',
    'flavor',
    'taste',
    'healthy food',
    'junk food',
    'fast food',
    'organic food',
    'vegetarian food',
    'vegan food',
    'halal food',
    'kosher food',
    'gluten-free food',
    'dairy-free food',
    'sugar-free food',
    'spicy food',
    'sweet food',
    'savory food',
    'salty food',
    'sour food',
    'bitter food',
    'appetizer',
    'main course',
    'dessert',
    'snack',
    'beverage',
    'drink',
    'coffee',
    'tea',
    'juice',
    'soda',
    'beer',
    'wine',
    'cocktail',
    'smoothie',
    'milkshake',
    'water',
    'pizza',
    'burger',
    'sandwich',
    'soup',
    'salad',
    'curry',
    'sushi',
    'taco',
    'burrito',
    'noodle'
  ];
  List<String> foodItemKeywords = [
    'pizza',
    'burger',
    'fries',
    'wings',
    'nuggets',
    'pasta',
    'sandwich',
    'wrap',
    'roll',
    'steak',
    'soup',
    'salad',
    'rice',
    'noodles',
    'dessert',
    'oven baked wings',
    'fried wings',
    'chicken nuggets',
    'loaded fries',
    'pizza fries',
    'garlic mayo fries',
    'french fries',
    'hot shots',
    'drum stick',
    'crispy zinger',
    'mighty zinger',
    'patty burger',
    'zinger stacker',
    'meet n eat special beef burger',
    'classic beef burger',
    'smoked beef burger',
    'crispy wrap',
    'kababish wrap',
    'cheetos wrap',
    'meet n eat special wrap',
    'mushroom steak',
    'jalapeno steak',
    'taragon steak',
    'black pepper steak',
    'mexican steak',
    'classic grilled chicken burger',
    'smoked grilled chicken burger',
    'meet n eat special grilled burger',
    'grilled chicken wrap',
    'grilled beef wrap',
    'grilled chicken sandwich',
    'beef grilled sandwich',
    'peri peri pizza',
    'chicken supreme pizza',
    'chicken tikka pizza',
    'chicken fajita pizza',
    'cheese lover pizza',
    'bonfire pizza',
    'veggie lover pizza',
    'malai boti pizza',
    'lazanai pizza',
    'tikka pizza',
    'fajita pizza',
    'creamy sandwich',
    'spin roll',
    'calzone chunks',
    'mexican sandwich',
    'pizza stacker',
    'juicy wings',
    'bbq wings',
    'hot wings',
    'crunchy pasta',
    'cheese pasta',
    'bbq fries',
    'hot shots',
    'nuggets',
    'mexican wrap',
    'chicken tikka pizza',
    'chicken fajita pizza',
    'hot & spicy pizza',
    'chicken supreme pizza',
    'american hot pizza',
    'tandoori chicken pizza',
    'cheesy pizza',
    'deep pan pizza',
    'stuff crust pizza',
    'square pizza',
    'extreme peri peri pizza',
    'pizza paratha',
    'pizza stick (cheese stick)'
  ];
  List<String> foodDealKeywords = [
    'food deal',
    'food offer',
    'food discount',
    'food promotion',
    'food special',
    'food combo',
    'meal deal',
    'dine-in deal',
    'takeaway deal',
    'delivery deal',
    'buy one get one',
    'BOGOF',
    'half price',
    'discount code',
    'voucher',
    'coupon',
    'promotion code',
    'special offer',
    'limited time offer',
    'seasonal offer',
    'festive offer',
    'pizza deal',
    'burger deal',
    'pasta deal',
    'chicken deal',
    'steak deal',
    'seafood deal',
    'dessert deal',
    'drink deal',
    'breakfast deal',
    'lunch deal',
    'dinner deal',
    'kids meal deal',
    'family meal deal',
    'party platter deal',
    'food deel',
    'food offfer',
    'food discont',
    'food promosion',
    'food spechial',
    'meel deal',
    'dine-in deall',
    'takeawy deal',
    'delivry deal',
    'buy one get onee',
    'half pricee',
    'discountt code',
    'vouchar',
    'couppon',
    'promosion code',
    'spechial offer',
    'limited time offfer',
    'seasonal offfer',
    'festive offfer',
    'deals',
    'deal',
    'del',
    'deal',
    'dael'
  ];

  // Restaurant Keywords
  List<String> meetNEatKeywords = [
    'meet n eat',
    'meet and eat',
    'meet n eat contact',
    'meet n eat location',
    'meet n eat menu',
    'meet n eat delivery'
  ];

  List<String> crustBrosKeywords = [
    'crust bros',
    'crust brothers',
    'crust bros contact',
    'crust bros location',
    'crust bros menu',
    'crust bros delivery'
  ];

  List<String> khanaKhazanaKeywords = [
    'khana khazana',
    'khana khazana contact',
    'khana khazana location',
    'khana khazana menu',
    'khana khazana delivery'
  ];

  List<String> mfcKeywords = [
    'miran jee',
    'miran jee food club',
    'mfc',
    'miran jee contact',
    'miran jee location',
    'miran jee delivery'
  ];

  List<String> pizzaSliceKeywords = [
    'pizza slice',
    'pizza slice contact',
    'pizza slice location',
    'pizza slice menu',
    'pizza slice delivery'
  ];

  List<String> tandoorKeywords = [
    'naan',
    'roti',
    'plain naan',
    'garlic naan',
    'cheese naan',
    'chicken cheese naan',
    'khamiri roti',
    'roghni naan',
    'kalwanji naan',
    'punjabi paratha'
  ];

  List<String> restaurantKeywords = [
    'restaurant',
    'restaurants',
    'hotel',
    'hotels',
    'food places',
    'eatery',
    'dining',
    'cafe',
    'cafes',
    'food shops'
  ];

  // Adding keywords related to food items

  @override
  void initState() {
    super.initState();
    _loadDataset();
    // Show welcome message
    _messages.add(ChatMessage(text: welcomeMessage, isUser: false));
  }

  Future<void> _loadDataset() async {
    try {
      // Here you can implement the logic to train the AI with the dataset
    } catch (e) {
      debugPrint('Error loading dataset: $e');
    }
  }

  // Modify respondToQuery to check for keywords
  String respondToQuery(String query) {
    query = query.toLowerCase();
    if (pizzaKeywords.any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Pizzas Available:  
Meet N Eat:  
- Peri Peri Pizza (Small: Rs. 500, Medium: Rs. 950, Large: Rs. 1200)  
- Malai Boti Pizza (Small: Rs. 600, Medium: Rs. 1100, Large: Rs. 1500)  
- Extreme Pizza (Medium: Rs. 1350, Large: Rs. 1600)  

Crust Bros:  
- Chicken Tikka (Small: Rs. 599, Medium: Rs. 1099, Large: Rs. 1399)  
- Creamy Pizza (Medium: Rs. 1299, Large: Rs. 1649)  

Miran Jee Food Club (MFC):  
- Lazania Malai Boti Pizza (Small: Rs. 650, Medium: Rs. 1100)  
- Supreme Pizza (Medium: Rs. 1350)  

Pizza Slice:  
- Lazania Pizza (Small: Rs. 600, Medium: Rs. 1200, Large: Rs. 1400)  
- Extreme Special Pizza (Small: Rs. 1300, Large: Rs. 1600)  
''';
    } else if (burgerKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Burgers Available:  
Meet N Eat:  
- Crispy Zinger: Rs. 350  
- Mighty Zinger: Rs. 600  
- Patty Burger: Rs. 280  

Crust Bros:  
- Zinger Burger: Rs. 399  

Pizza Slice:  
- Zinger Burger: Rs. 330  

MFC:  
- Zinger Burger: Rs. 440 (with 1.5L drink in deal)  
''';
    } else if (query.contains('cheap') || query.contains('cheapest')) {
      return '''Cheapest Food Options:  
- Plain Naan (Khana Khazana) - Rs. 40  
- Chicken Shawarma (Meet N Eat) - Rs. 200  
- Patty Burger (Meet N Eat) - Rs. 280  
- Regular Fries (Pizza Slice) - Rs. 200  
- Small Drink (Crust Bros) - Rs. 70  
''';
    } else if (friesKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Fries Available:  
- Loaded Fries from Meet N Eat - Rs. 400  
- Pizza Fries from Meet N Eat - Rs. 750  
- Garlic Mayo Fries from Meet N Eat - Rs. 300  
- French Fries from Meet N Eat - Rs. 250  
''';
    } else if (wrapsKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Wraps Available:  
- Crispy Wrap from Meet N Eat - Rs. 450  
- Kababish Wrap from Meet N Eat - Rs. 450  
- Cheetos Wrap from Meet N Eat - Rs. 550  
''';
    } else if (foodDealKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''🎉 Food Deals:
- Deal 1: 1 Zinger Burger, Small Fries, 350ml Soft Drink - Rs. 600/- from Meet N Eat
- Deal 2: 1 Mighty Burger, Regular Fries, 350ml Soft Drink - Rs. 800/- from Meet N Eat
- Deal 3: 2 Zinger Burgers, 2 Pieces Crispy Wings, Small Fries, 500ml Soft Drink - Rs. 1100/- from Meet N Eat
- Deal 4: 2 Zinger Burgers, Patty Burger, Large Fries, 1L Soft Drink - Rs. 1400/- from Meet N Eat
- Deal 5: 1 Chicken Shawarma, 1 Zinger Burger, 500ml Soft Drink - Rs. 1100/- from Meet N Eat
- Deal 6: 1 Flaming Pasta, 500ml Soft Drink - Rs. 590/- from Meet N Eat
- Deal 7: 1 Tikka Sandwich, 1 Zinger Burger, 500ml Soft Drink - Rs. 950/- from Meet N Eat
- Deal 8: Fried Chicken Half, Kabab Paratha Roll, 500ml Soft Drink - Rs. 900/- from Meet N Eat
''';
    } else if (pastaKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Pasta Available:
- Fettuccine Pasta from Meet N Eat - Rs. 500
- Flaming Pasta from Meet N Eat - Rs. 590
- Fajita Pasta from Meet N Eat - Rs. 700
- Crunchy Pasta from Crust Bros - Rs. 549
- Cheese Pasta from Pizza Slice - Rs. 649
''';
    } else if (wingsKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Wings Available:
- Oven Baked Wings from Meet N Eat - Rs. 390
- Fried Wings from Meet N Eat - Rs. 350
- Juicy Wings from Crust Bros - (5 Pcs: Rs. 299, 10 Pcs: Rs. 599)
- BBQ Wings from Pizza Slice - Rs. 450
''';
    } else if (nuggetsKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Nuggets & Hot Shots:
- Chicken Nuggets from Meet N Eat - Rs. 350
- Hot Shots from Meet N Eat - Rs. 350
- Crispy Nuggets from Pizza Slice - Rs. 400
''';
    } else if (sandwichKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Sandwiches Available:
- Grilled Chicken Sandwich from Meet N Eat - Rs. 450
- Beef Grilled Sandwich from Meet N Eat - Rs. 550
- Club Sandwich from Crust Bros - Rs. 399
- Mexican Sandwich from Pizza Slice - Rs. 450
''';
    } else if (grilledKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Grilled Items:
- Mushroom Steak from Meet N Eat - Rs. 1000
- Jalapeno Steak from Meet N Eat - Rs. 1100
- Black Pepper Steak from Meet N Eat - Rs. 1000
- Mexican Steak from Meet N Eat - Rs. 1000
- Classic Grilled Chicken Burger from Meet N Eat - Rs. 350
''';
    } else if (khanaKhazanaTandoorKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Khana Khazana Tandoor Details:
📞 Contact: 0345-7277634, 0309-4152186
📍 Location: Main Super Highway Bahawal Pur Road, Near Total Petrol Pump, Jahanian
🍽️ Menu Highlights:
- Roti
- Plain Naan
- Garlic Naan
- Roghni Naan
- Cheese Naan
''';
    } else if (dessertKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Desserts:
- Fruit Trifle from Khana Khazana - Rs. 300
- Gajar Halwa from Khana Khazana - Rs. 350
- Brownie from Pizza Slice - Rs. 250
- Hot Gulab Jamun from Pizza Slice - Rs. 280
''';
    } else if (beverageKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Beverages:
- Soft Drinks (500ml: Rs. 70, 1L: Rs. 160, 1.5L: Rs. 220)
- Mineral Water - Rs. 60
- Green Tea - Rs. 100
- Kashmiri Chai - Rs. 150
''';
    } else if (bbqKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''BBQ Items:
- Malai Boti from Khana Khazana - Rs. 800
- Tikka Boti from Khana Khazana - Rs. 750
- Reshmi Kabab from Khana Khazana - Rs. 700
- BBQ Leg Piece from Meet N Eat - Rs. 450
''';
    } else if (chineseKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Chinese Items:
- Chicken Chowmein from Khana Khazana - Rs. 450
- Fried Rice from Khana Khazana - Rs. 400
- Garlic Rice from Meet N Eat - Rs. 350
- American Chopsuey from Khana Khazana - Rs. 500
''';
    } else if (appetizerKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Appetizers:
- Chicken Pakora from Khana Khazana - Rs. 300
- Crispy Wings from Meet N Eat - Rs. 350
- Spin Roll from Pizza Slice - Rs. 250
- Cheese Sticks from Crust Bros - Rs. 299
''';
    } else if (meetNEatKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Meet N Eat Details:
📞 Contact: 0328-5500112, 0310-5083300
📍 Location: Opposite Nadra Office, Multan Road, Jahanian
🚚 Delivery: Fast delivery available with online payment option
🍽️ Menu Highlights: 
- Burgers
- Wings
- Wraps
- Pizzas
- Grilled Chicken
- Pasta
- Sandwiches
- Special Deals

Opening Hours: 11:00 AM - 12:00 AM
''';
    } else if (crustBrosKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Crust Bros Details:
📞 Contact: 0325-800-3399, 0327-800-3399
📍 Location: Loha Bazar, Jahanian
🏪 Branches: Mian Channu, Khanewal, Chichawatni
🍽️ Menu Highlights:
- Pizzas
- Platters
- Wings
- Pasta
- Sandwiches
- Wraps
- Burgers

Contact restaurant for delivery availability
''';
    } else if (khanaKhazanaKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Khana Khazana Details:
📞 Contact: 0345-7277634, 0309-4152186
📍 Location: Main Super Highway Bahawal Pur Road, Near Total Petrol Pump, Jahanian
🚚 Delivery: Available
✨ Special Facilities:
- Air-conditioned hall for events
- Pre-order required for special dishes
🍽️ Menu Highlights:
- BBQ Platters
- Handi
- Tandoor
- Soups
- Rice
- Chowmein
- Biryani
- Tea Bar
- Desserts
''';
    } else if (mfcKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Miran Jee Food Club (MFC) Details:
📞 Contact: 0309-7000178, 0306-7587938
📍 Location: Branch 1: Near Ice Factory, Rahim Shah Road, Jahanian
🚚 Delivery: 
- Free delivery within 3 km (Minimum order Rs. 600)
- Rs. 40 delivery charge for smaller orders
✨ Special Facilities:
- Hall available for parties and functions
🍽️ Menu Highlights:
- Deals
- Pizzas
- Burgers
- Rolls
- Wings
- Sandwiches
- Pasta
''';
    } else if (pizzaSliceKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Pizza Slice Details:
📞 Contact: 0308-4824792, 0311-4971155, 0303-4971155
📍 Location: Main Khanewall Highway Road, Infront of Qudas Masjid, Jahanian
🚚 Delivery: Free home delivery for orders above Rs. 800 within the city
🍽️ Menu Highlights:
- Pizzas
- Burgers
- Sandwiches
- Wraps
- Wings
- Special Deals
''';
    } else if (tandoorKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Tandoor Items:
- Plain Naan from Khana Khazana - Rs. 40
- Garlic Naan from Khana Khazana - Rs. 60
- Roghni Naan from Khana Khazana - Rs. 50
- Cheese Naan from Meet N Eat - Rs. 150
''';
    } else if (restaurantKeywords
        .any((keyword) => query.contains(keyword.toLowerCase()))) {
      return '''Available Restaurants in Jahanian:

1. 🏪 Meet N Eat
   📞 Contact: 0328-5500112, 0310-5083300
   📍 Location: Opposite Nadra Office, Multan Road
   ⭐ Known for: Fast Food, Pizza, Burgers, Grilled Items
   🕒 Hours: 11:00 AM - 12:00 AM

2. 🏪 Crust Bros
   📞 Contact: 0325-800-3399, 0327-800-3399
   📍 Location: Loha Bazar
   ⭐ Known for: Pizza, Wings, Burgers
   🏪 Multiple Branches: Mian Channu, Khanewal, Chichawatni

3. 🏪 Khana Khazana
   📞 Contact: 0345-7277634, 0309-4152186
   📍 Location: Main Super Highway Bahawal Pur Road
   ⭐ Known for: BBQ, Traditional Food, Chinese
   ✨ Special: Air-conditioned hall for events

4. 🏪 Miran Jee Food Club (MFC)
   📞 Contact: 0309-7000178, 0306-7587938
   📍 Location: Near Ice Factory, Rahim Shah Road
   ⭐ Known for: Pizza, Burgers, Deals
   🚚 Free delivery within 3km

5. 🏪 Pizza Slice
   📞 Contact: 0308-4824792, 0311-4971155
   📍 Location: Main Khanewall Highway Road
   ⭐ Known for: Pizza, Burgers, Wings
   🚚 Free delivery for orders above Rs. 800

6. 🏪 Khana Khazana Tandoor
   📞 Contact: 0345-7277634, 0309-4152186
   📍 Location: Main Super Highway Bahawal Pur Road
   ⭐ Known for: Fresh Naan, Roti, Traditional Bread

Ask about any specific restaurant for more detailed information!
''';
    } else if (query.contains("what's special at mfc") ||
        query.contains("mfc special")) {
      return '''🏪 MFC (Meeran Jee Food Club) Specialties:

🍔 Premium Burgers:
• Zinger Burger Supreme (Rs. 440)
• Double Decker Burger (Rs. 550)

🌯 Signature Shawarma:
• Special Chicken Shawarma (Rs. 280)
• Shawarma Platter with Fries (Rs. 450)

🍕 Special Pizzas:
• BBQ Ranch Pizza (M: Rs. 999, L: Rs. 1299)
• Chicken Fajita Pizza (M: Rs. 1099, L: Rs. 1399)

🥙 Fresh Rolls:
• Chicken Paratha Roll (Rs. 220)
• Zinger Paratha Roll (Rs. 250)

🍝 Italian Corner:
• Creamy Alfredo Pasta (Rs. 450)
• Spicy Arrabiata (Rs. 420)

All items come with our special MFC sauce! 😋
''';
    } else if (query.contains("most popular") ||
        query.contains("best sellers")) {
      return '''🌟 Most Popular Items from Each Restaurant:

1. Meet N Eat:
   • Ultimate Chicken Pizza (Rs. 1200) ⭐4.8
   • Double Patty Zinger Burger (Rs. 550) ⭐4.7

2. Crust Bros:
   • Stuffed Crust BBQ Pizza (Rs. 1299) ⭐4.8
   • Chicken Wrap Supreme (Rs. 350) ⭐4.6

3. Khana Khazana:
   • Special Seekh Kebab Roll (Rs. 280) ⭐4.7
   • Chicken Biryani (Rs. 300) ⭐4.9

4. MFC:
   • Chicken Shawarma Deluxe (Rs. 280) ⭐4.8
   • Spicy Zinger Burger (Rs. 440) ⭐4.7

All items available for delivery! 🛵
''';
    } else if (query.contains("top rated pizza") ||
        query.contains("best pizza")) {
      return '''🍕 Top Rated Pizzas in Jahanian:

1. Meet N Eat:
   • Ultimate Cheese Lover (M: Rs. 1100, L: Rs. 1400)
   - Double cheese, mozzarella, cheddar blend
   
2. Crust Bros:
   • Premium Deep Pan BBQ (M: Rs. 1199, L: Rs. 1499)
   - Special BBQ sauce, extra toppings

3. MFC:
   • Special Chicken Supreme (M: Rs. 999, L: Rs. 1299)
   - Loaded with premium chicken toppings

4. Khana Khazana:
   • Tandoori Chicken Pizza (M: Rs. 1100, L: Rs. 1400)
   - Special tandoori sauce base

All pizzas come with free delivery on orders above Rs. 1000! 🛵
''';
    } else if (query.contains("pizza slice menu")) {
      return '''🍕 Pizza Slice Complete Menu:

1. Regular Pizzas:
   • Chicken Tikka (M: Rs. 899, L: Rs. 1199)
   • Fajita (M: Rs. 999, L: Rs. 1299)
   • BBQ Ranch (M: Rs. 1099, L: Rs. 1399)

2. Special Pizzas:
   • Supreme (M: Rs. 1199, L: Rs. 1499)
   • Cheese Lover (M: Rs. 1099, L: Rs. 1399)
   
3. Deep Pan Pizzas:
   • Mexican (L: Rs. 1599)
   • Arabian (L: Rs. 1499)

4. Stuffed Crust:
   • Chicken Supreme (L: Rs. 1699)
   • BBQ Special (L: Rs. 1599)

5. Combo Deals:
   • Family Deal: L Pizza + 4 Drinks (Rs. 1999)
   • Friends Deal: M Pizza + 2 Drinks (Rs. 1299)

📞 Contact: 0308-4824792
🏠 Location: Main Khanewall Highway Road
''';
    } else if (query.contains("shawarma") || query.contains("burrito")) {
      return '''🌯 Shawarma & Burrito Options:

1. Meet N Eat:
   • Chicken Burrito Wrap (Rs. 350)
   • Shawarma Platter with Fries (Rs. 450)
   • Special Deal: 2 Shawarmas + Drink (Rs. 550)

2. Crust Bros:
   • Chicken Burrito Bowl (Rs. 399)
   • Spicy Shawarma Wrap (Rs. 280)
   • Combo: Shawarma + Fries + Drink (Rs. 450)

3. Khana Khazana:
   • BBQ Shawarma (Rs. 250)
   • Seekh Kebab Shawarma Roll (Rs. 300)
   • Family Pack: 4 Shawarmas (Rs. 899)

4. MFC:
   • Chicken Shawarma Deluxe (Rs. 280)
   • Paratha Shawarma Roll (Rs. 320)
   • Deal: 2 Shawarmas + Fries (Rs. 599)

All shawarmas come with special garlic sauce! 🥙
''';
    } else {
      return '''Please ask about any of these items:
- Pizza 🍕
- Burgers 🍔
- Wraps & Rolls 🌯
- Pasta 🍝
- Fries 🍟
- Wings 🍗
- Nuggets & Hot Shots
- Sandwiches 🥪
- Grilled Items
- Tandoor Items
- Desserts 🍰
- Beverages 🥤
- BBQ Items
- Chinese Items
- Appetizers
- Food Deals 🎉
- Cheapest Options 💰''';
    }
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));

      String response = respondToQuery(text.toLowerCase());

      _messages.add(ChatMessage(
        text: response,
        isUser: false,
      ));
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/jarvis.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jarvis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Torbaaz AI chat bot',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ask about menu items...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            _handleSubmitted(_messageController.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/jarvis.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[700] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
