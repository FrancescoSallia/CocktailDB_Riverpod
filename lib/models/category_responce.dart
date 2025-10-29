import 'package:riverpod_lerning_flutter/models/category.dart';

class CategoryResponce {
  final List<Category> drinks;

  CategoryResponce({required this.drinks});

  Map<String, dynamic> toJson() => {
    "drinks": drinks.map((e) => e.toJson()).toList(),
  };

  factory CategoryResponce.fromJson(Map<String, dynamic> json) {
    return CategoryResponce(
      drinks: (json["drinks"] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
