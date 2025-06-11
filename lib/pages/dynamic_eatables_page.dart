import 'package:flutter/material.dart';
import '../utils/database_service.dart';

class DynamicEatablesPage extends StatefulWidget {
  const DynamicEatablesPage({Key? key}) : super(key: key);

  @override
  State<DynamicEatablesPage> createState() => _DynamicEatablesPageState();
}

class _DynamicEatablesPageState extends State<DynamicEatablesPage> {
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = true;
  List<Map<String, dynamic>> _eatables = [];
  List<Map<String, dynamic>> _filteredEatables = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadEatables();
  }

  Future<void> _loadEatables() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final eatables = await _databaseService.getEatables();

      setState(() {
        _eatables = eatables;
        _filteredEatables = eatables;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showMessage('Failed to load eatables: $e');
    }
  }

  void _filterEatables(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredEatables = _eatables;
      } else {
        _filteredEatables = _eatables.where((eatable) {
          final name = (eatable['name'] ?? '').toLowerCase();
          final description = (eatable['description'] ?? '').toLowerCase();
          return name.contains(query.toLowerCase()) ||
              description.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eatables'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search eatables...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: _filterEatables,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredEatables.isEmpty
                    ? Center(
                        child: Text(
                          _searchQuery.isEmpty
                              ? 'No eatables available'
                              : 'No eatables match your search',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredEatables.length,
                        itemBuilder: (context, index) {
                          final eatable = _filteredEatables[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eatable['name'] ?? 'Unnamed',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if (eatable['description'] != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      eatable['description'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        eatable['restaurants']?['name'] ??
                                            'Unknown restaurant',
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      Text(
                                        eatable['price'] != null
                                            ? 'Rs. ${eatable['price']}'
                                            : 'No price',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
