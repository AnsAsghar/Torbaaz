import 'dart:convert';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final bool synced;

  User({
    String? id,
    required this.name,
    this.synced = false,
  }) : this.id = id ?? const Uuid().v4();

  // Convert User instance to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'data': jsonEncode({'name': name}),
      'synced': synced ? 1 : 0,
    };
  }

  // Create User instance from database map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      synced: map['synced'] == 1,
    );
  }

  // Create User instance from Supabase response
  factory User.fromSupabase(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      synced: true,
    );
  }

  // Create a copy of this User with modified properties
  User copyWith({
    String? id,
    String? name,
    bool? synced,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      synced: synced ?? this.synced,
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, synced: $synced)';
}
