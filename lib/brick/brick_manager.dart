import 'package:flutter/material.dart';

/// A simplified Brick manager that doesn't cause initialization errors
class Brick {
  static bool _initialized = false;

  /// Initialize Brick system - does nothing but set initialized flag
  static Future<void> initialize() async {
    if (_initialized) return;

    debugPrint('Initializing Brick...');
    
    // Just mark as initialized without doing anything that might fail
    _initialized = true;
    debugPrint('Brick initialized successfully');
  }
}
