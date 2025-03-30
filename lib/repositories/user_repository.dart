import '../models/user.dart';
import '../services/supabase_service.dart';

class UserRepository {
  final SupabaseService _supabaseService;

  UserRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService.instance;

  // Save a user to both local and remote storage
  Future<void> saveUser(User user) async {
    await _supabaseService.saveUser(
      id: user.id,
      name: user.name,
    );
  }

  // Get a user by ID (tries local first, then remote)
  Future<User?> getUser(String id) async {
    // Try to get from local storage first
    final localUser = await _supabaseService.getUserLocal(id);
    if (localUser != null) {
      return User.fromMap(localUser);
    }

    // If not in local storage, try to get from Supabase
    final remoteUser = await _supabaseService.getUserRemote(id);
    if (remoteUser != null) {
      final user = User.fromSupabase(remoteUser);

      // Save to local database for offline access
      await saveUser(user);

      return user;
    }

    return null;
  }

  // Sync any unsynced data to Supabase
  Future<void> syncUnsyncedData() async {
    await _supabaseService.syncUnsyncedData();
  }
}
