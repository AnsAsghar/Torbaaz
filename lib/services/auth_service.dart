import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as models;

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Get the current authenticated user
  models.User? get currentUser {
    final supabaseUser = _supabaseClient.auth.currentUser;
    if (supabaseUser == null) return null;

    // Return a simplified user object for immediate use
    return models.User(
      id: supabaseUser.id,
      name: supabaseUser.userMetadata?['name'] ?? 'User',
    );
  }

  // Get full user profile from database
  Future<models.User?> getCurrentUserProfile() async {
    try {
      final supabaseUser = _supabaseClient.auth.currentUser;
      if (supabaseUser == null) return null;

      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', supabaseUser.id)
          .maybeSingle();

      if (response == null) {
        // User exists in auth but not in profiles table
        return models.User(
          id: supabaseUser.id,
          name: supabaseUser.userMetadata?['name'] ?? 'User',
        );
      }

      return models.User.fromSupabase(response);
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    final response = await _supabaseClient.auth
        .signUp(email: email, password: password, data: {
      'name': name,
    });

    if (response.user != null) {
      // Create user profile in profiles table
      await _supabaseClient.from('profiles').insert({
        'id': response.user!.id,
        'name': name,
      });
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Listen to auth state changes
  Stream<models.User?> authStateChanges() {
    return _supabaseClient.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;

      return models.User(
        id: user.id,
        name: user.userMetadata?['name'] ?? 'User',
      );
    });
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  // Update user profile
  Future<void> updateUserProfile(models.User user) async {
    await _supabaseClient
        .from('profiles')
        .update(user.toMap())
        .eq('id', user.id);
  }
}
