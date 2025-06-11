import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Admin credentials - in production, these should be stored securely
  // Fixed for now as requested, with email and password only known by admin
  static const String adminEmail = 'admin@torbaaz.com';
  static const String adminPassword = 'TorbaazAdmin@123';

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  // Check if user is admin
  bool get isAdmin => currentUser?.email == adminEmail;

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password,
      {bool checkAdminCredentials = true}) async {
    try {
      // First check if the credentials match the hardcoded admin credentials
      if (checkAdminCredentials &&
          email == adminEmail &&
          password == adminPassword) {
        // Try to sign in with Supabase if credentials match
        try {
          final response = await _supabase.auth.signInWithPassword(
            email: email,
            password: password,
          );

          return response.user != null;
        } catch (e) {
          // If Supabase auth fails but credentials match admin credentials,
          // we'll consider it a successful login for the admin
          debugPrint('Admin login with hardcoded credentials: $e');
          return true;
        }
      } else if (!checkAdminCredentials) {
        // Regular user login through Supabase
        final response = await _supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );

        return response.user != null;
      }

      return false;
    } catch (e) {
      debugPrint('Error signing in: $e');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  // Get user's email
  String? get userEmail => currentUser?.email ?? adminEmail;

  // Check if user has admin role from Supabase
  Future<bool> hasAdminRole() async {
    try {
      if (currentUser == null) return false;

      // This assumes you have a 'user_roles' table in Supabase
      // with 'user_id' and 'role' columns
      final response = await _supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', currentUser!.id)
          .single();

      return response['role'] == 'admin';
    } catch (e) {
      debugPrint('Error checking admin role: $e');
      // Fall back to email check if the query fails
      return isAdmin;
    }
  }
}
