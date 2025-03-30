import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._();
  static SupabaseService get instance => _instance;
  
  bool _initialized = false;
  Database? _localDb;
  
  SupabaseService._();

  // Initialize Supabase
  Future<void> initialize({
    required String supabaseUrl,
    required String supabaseKey,
  }) async {
    if (_initialized) return;
    
    try {
      // Initialize Supabase
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
      );
      
      // Initialize local database for offline storage
      _localDb = await _initializeLocalDb();
      
      _initialized = true;
      debugPrint('✅ Supabase initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing Supabase: $e');
      rethrow;
    }
  }
  
  // Initialize local SQLite database
  Future<Database> _initializeLocalDb() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = p.join(directory.path, 'app_database.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create users table
        await db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            data TEXT,
            synced INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }
  
  // Get Supabase client
  SupabaseClient get client => Supabase.instance.client;
  
  // Get local database
  Database? get localDb => _localDb;
  
  // Save user to both local db and Supabase
  Future<void> saveUser({required String id, required String name}) async {
    try {
      // Save to local database
      await _localDb?.insert(
        'users',
        {
          'id': id,
          'name': name,
          'data': jsonEncode({'name': name}),
          'synced': 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      
      // Save to Supabase
      await client.from('users').upsert({
        'id': id,
        'name': name,
      });
      
      // Update synced status
      await _localDb?.update(
        'users',
        {'synced': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('Error saving user: $e');
      // Data is still saved locally even if Supabase sync fails
    }
  }
  
  // Get user from local database
  Future<Map<String, dynamic>?> getUserLocal(String id) async {
    final List<Map<String, dynamic>>? results = await _localDb?.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (results != null && results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
  
  // Get user from Supabase
  Future<Map<String, dynamic>?> getUserRemote(String id) async {
    final response = await client
        .from('users')
        .select()
        .eq('id', id)
        .limit(1)
        .maybeSingle();
    
    return response;
  }
  
  // Sync all unsynced local data to Supabase
  Future<void> syncUnsyncedData() async {
    final List<Map<String, dynamic>>? unsynced = await _localDb?.query(
      'users',
      where: 'synced = ?',
      whereArgs: [0],
    );
    
    if (unsynced == null || unsynced.isEmpty) return;
    
    for (final user in unsynced) {
      try {
        await client.from('users').upsert({
          'id': user['id'],
          'name': user['name'],
        });
        
        await _localDb?.update(
          'users',
          {'synced': 1},
          where: 'id = ?',
          whereArgs: [user['id']],
        );
      } catch (e) {
        debugPrint('Error syncing user ${user['id']}: $e');
      }
    }
  }
} 