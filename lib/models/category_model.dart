import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final String icon;
  final int colorValue;
  final String type; // 'income' or 'expense'
  final bool isDefault;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.icon,
    required this.colorValue,
    required this.type,
    this.isDefault = false,
  });

  Color get color => Color(colorValue);

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      icon: map['icon'] ?? '📁',
      colorValue: map['colorValue'] ?? 0xFF6C5CE7,
      type: map['type'] ?? 'expense',
      isDefault: map['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'icon': icon,
      'colorValue': colorValue,
      'type': type,
      'isDefault': isDefault,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? icon,
    int? colorValue,
    String? type,
    bool? isDefault,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      colorValue: colorValue ?? this.colorValue,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
