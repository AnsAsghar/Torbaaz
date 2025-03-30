class FoodItem {
  final String name;
  final String restaurant;
  final String description;
  final String price;
  final List<String> searchKeywords;
  String imageUrl; // Make this non-final to allow updates
  final String size; // Add this field to represent the size

  FoodItem({
    required this.name,
    required this.restaurant,
    required this.description,
    required this.price,
    required this.searchKeywords,
    required this.imageUrl,
    required this.size, // Include size in the constructor
  });

  // Parse an individual line from the dataset
  factory FoodItem.fromLine(String line, Map<String, String> imageMap) {
    var data = line.split(
        ','); // Assuming each field in your dataset is separated by commas
    var name = data[0].trim();
    var imageUrl = imageMap[name.split(' ')[0]] ??
        'https://images.pexels.com/photos/default.jpeg';
    return FoodItem(
      name: name,
      restaurant: data[1].trim(),
      description: data[2].trim(),
      price: data[3].trim(),
      searchKeywords: data[4]
          .trim()
          .split('|')
          .map((s) => s.trim())
          .toList(), // Assuming keywords are separated by '|'
      imageUrl: imageUrl,
      size: data.length > 5
          ? data[5].trim()
          : 'Standard', // Add size with default value
    );
  }

  bool matchesSearch(String query) {
    final lowercaseQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowercaseQuery) ||
        description.toLowerCase().contains(lowercaseQuery) ||
        searchKeywords
            .any((keyword) => keyword.toLowerCase().contains(lowercaseQuery));
  }
}

List<FoodItem> loadFoodItems(String dataset, Map<String, String> imageMap) {
  List<FoodItem> items = [];
  final lines = dataset.split('\n');
  for (var line in lines) {
    items.add(FoodItem.fromLine(line, imageMap));
  }
  return items;
}
