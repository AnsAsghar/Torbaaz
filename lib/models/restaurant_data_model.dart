class BasicInfo {
  final String fullName;
  final int? established;
  final String type;
  final double? googleRating;

  const BasicInfo({
    required this.fullName,
    this.established,
    required this.type,
    this.googleRating,
  });
}

class ContactDetails {
  final String address;
  final String phone;
  final String mapLink;

  const ContactDetails({
    required this.address,
    required this.phone,
    required this.mapLink,
  });
}

class MenuCategory {
  final String name;
  final String description;
  final double price;
  final List<String> size;

  const MenuCategory({
    required this.name,
    required this.description,
    required this.price,
    required this.size,
  });
}

class RestaurantDataModel {
  final String id;
  final String name;
  final BasicInfo basicInfo;
  final ContactDetails contactDetails;
  final List<MenuCategory> menuCategories;

  const RestaurantDataModel({
    required this.id,
    required this.name,
    required this.basicInfo,
    required this.contactDetails,
    required this.menuCategories,
  });
}
