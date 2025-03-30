import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../services/supabase_service.dart';

class SupabaseExample extends StatefulWidget {
  const SupabaseExample({Key? key}) : super(key: key);

  @override
  _SupabaseExampleState createState() => _SupabaseExampleState();
}

class _SupabaseExampleState extends State<SupabaseExample> {
  final SupabaseService _supabaseService = SupabaseService.instance;
  late UserRepository _userRepository;
  final _nameController = TextEditingController();

  String? _userId;
  User? _currentUser;
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    _initializeSupabase();
  }

  Future<void> _initializeSupabase() async {
    setState(() => _isLoading = true);

    try {
      await _supabaseService.initialize(
        supabaseUrl: 'YOUR_SUPABASE_URL',
        supabaseKey: 'YOUR_SUPABASE_KEY',
      );
      setState(() => _statusMessage = 'Supabase initialized successfully');
    } catch (e) {
      setState(() => _statusMessage = 'Error initializing Supabase: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createUser() async {
    if (_nameController.text.isEmpty) {
      setState(() => _statusMessage = 'Please enter a name');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = User(name: _nameController.text);
      await _userRepository.saveUser(user);

      setState(() {
        _userId = user.id;
        _currentUser = user;
        _statusMessage = 'User created successfully with ID: ${user.id}';
      });
    } catch (e) {
      setState(() => _statusMessage = 'Error creating user: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getUser() async {
    if (_userId == null) {
      setState(() => _statusMessage = 'No user ID available');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _userRepository.getUser(_userId!);

      setState(() {
        _currentUser = user;
        _statusMessage =
            user != null ? 'User retrieved: ${user.name}' : 'User not found';
      });
    } catch (e) {
      setState(() => _statusMessage = 'Error retrieving user: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _syncData() async {
    setState(() => _isLoading = true);

    try {
      await _userRepository.syncUnsyncedData();
      setState(() => _statusMessage = 'Data synced successfully');
    } catch (e) {
      setState(() => _statusMessage = 'Error syncing data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supabase Example'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _createUser,
                    child: Text('Create User'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _getUser,
                    child: Text('Get User'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _syncData,
                    child: Text('Sync Unsynced Data'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Status: $_statusMessage',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  if (_currentUser != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User Details:'),
                            Text('ID: ${_currentUser!.id}'),
                            Text('Name: ${_currentUser!.name}'),
                            Text(
                                'Synced: ${_currentUser!.synced ? 'Yes' : 'No'}'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
