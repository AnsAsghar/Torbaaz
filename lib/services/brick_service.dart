import 'package:flutter/foundation.dart';
import '../brick/repository.dart';

class BrickService {
  static final BrickService _instance = BrickService._();
  static BrickService get instance => _instance;

  bool _initialized = false;
  BrickService._();

  /// Initialize Brick with Supabase
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await BrickRepository.instance.initialize(
        supabaseUrl: 'YOUR_SUPABASE_URL',  // Replace with your Supabase URL
        supabaseKey: 'YOUR_SUPABASE_KEY',  // Replace with your Supabase API key
      );
      _initialized = true;
      debugPrint('✅ Brick initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing Brick: $e');
      rethrow;
    }
  }

  /// Access to repository
  BrickRepository get repository => BrickRepository.instance;
} 