import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_sqlite/db.dart';
import 'package:brick_supabase/brick_supabase.dart' as brick_supabase;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Generated imports will be available after running build_runner
// import 'package:torbaaz/brick/adapters/user_adapter.dart';
// import 'package:torbaaz/brick/db/schema.g.dart';

/// Your app's storage mechanism and API connection
class BrickRepository {
  static final BrickRepository _instance = BrickRepository._();
  static BrickRepository get instance => _instance;

  BrickRepository._();

  // Initialize the repository with your Supabase credentials
  Future<void> initialize({
    required String supabaseUrl,
    required String supabaseKey,
  }) async {
    // Initialize Supabase
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );

    // Initialize SQLite database
    final databasePath = await _getDatabasePath();
    print('Database initialized at: $databasePath');

    // Additional initialization can be added after code generation works
  }

  // Get the database path
  Future<String> _getDatabasePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return p.join(directory.path, 'brick.sqlite');
  }

  // Access Supabase client
  SupabaseClient get supabase => Supabase.instance.client;
}
