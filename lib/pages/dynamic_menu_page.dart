import 'package:flutter/material.dart';
import '../utils/database_service.dart';

class DynamicMenuPage extends StatefulWidget {
  const DynamicMenuPage({Key? key}) : super(key: key);

  @override
  State<DynamicMenuPage> createState() => _DynamicMenuPageState();
}

class _DynamicMenuPageState extends State<DynamicMenuPage> {
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = true;
  List<Map<String, dynamic>> _menuImages = [];

  @override
  void initState() {
    super.initState();
    _loadMenuImages();
  }

  Future<void> _loadMenuImages() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final images = await _databaseService.getMenuImages();

      setState(() {
        _menuImages = images;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showMessage('Failed to load menu images: $e');
    }
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
        title: const Text('Menu'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _menuImages.isEmpty
              ? _buildEmptyState()
              : _buildMenuImagesGrid(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No menu images available',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadMenuImages,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuImagesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _menuImages.length,
      itemBuilder: (context, index) {
        final image = _menuImages[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: image['image_url'] != null
                    ? Image.network(
                        image['image_url'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (ctx, error, stack) => const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  image['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
