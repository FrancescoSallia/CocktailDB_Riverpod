import 'package:riverpod_lerning_flutter/models/cocktail.dart';

class CocktailResponce {
  final List<Cocktail> drinks;

  CocktailResponce(this.drinks);

  Map<String, dynamic> toJson() => {
    "drinks": drinks.map((e) => e.toJson()).toList(),
  };

  factory CocktailResponce.fromJson(Map<String, dynamic> json) {
    return CocktailResponce(
      (json["drinks"] as List<dynamic>)
          .map((e) => Cocktail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
