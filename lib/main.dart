import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/menu_page.dart';
import 'pages/ai_assistant_page.dart';
import 'pages/food_deals_page.dart';
import 'pages/restaurant_details_page.dart';
import 'pages/eatables_list_page.dart';
import 'pages/feedback_page.dart';
import 'pages/about_page.dart';
import 'pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'brick/brick_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Brick.initialize();
    debugPrint('Brick initialized successfully');
  } catch (e) {
    debugPrint('Error initializing Brick: $e');
    // Continue even if Brick fails
  }

  try {
    await Supabase.initialize(
      url: "https://xfvbgpybpjumgdvfuidk.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhmdmJncHlicGp1bWdkdmZ1aWRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMzMDg4NzYsImV4cCI6MjA1ODg4NDg3Nn0.733PF37TcZDhza5PINnn78B21UWZ_el_4U_IKQW8iLk",
    );
    debugPrint('Supabase initialized successfully');
  } catch (e) {
    debugPrint('Error initializing Supabase: $e');
    // Continue even if Supabase fails
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Torbaaz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          displayMedium: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
          displaySmall: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
          headlineMedium: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          headlineSmall: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
          titleLarge: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          bodyLarge: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
          bodyMedium: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
          titleMedium: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          titleSmall: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasError = false;
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    // Safety timeout - increased to 8 seconds to give animation time to play
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted && !_animationComplete) {
        _navigateToMain();
      }
    });
  }

  void _navigateToMain() {
    if (mounted) {
      setState(() {
        _animationComplete = true;
      });
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _hasError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 80),
                      const SizedBox(height: 20),
                      Text('Error loading animation',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                : Lottie.asset(
                    'assets/splash.json',
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.contain,
                    repeat: false, // Don't repeat the animation
                    onLoaded: (composition) {
                      // Let the animation finish, then navigate
                      Future.delayed(
                          composition.duration +
                              const Duration(milliseconds: 500), () {
                        if (mounted) {
                          _navigateToMain();
                        }
                      });
                    },
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading Lottie animation: $error');
                      setState(() {
                        _hasError = true;
                      });
                      return const Icon(Icons.error_outline,
                          color: Colors.red, size: 80);
                    },
                  ),
          ),
          // Discrete button at the bottom
          Positioned(
            bottom: 20,
            right: 20,
            child: Opacity(
              opacity: 0.7,
              child: TextButton(
                onPressed: _navigateToMain,
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MenuPage(),
    const FoodDealsPage(),
    const RestaurantDetailsPage(),
    const EatablesListPage(),
    const FeedbackPage(),
    const AIAssistantPage(),
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Menu',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Food Deals',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Restaurants',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Eatables',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: 'Feedback',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy),
              label: 'AI Assistant',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
