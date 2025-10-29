import 'package:riverpod_lerning_flutter/models/cocktail.dart';

class CocktailListState {
  final List<Cocktail> drinks;
  final bool isLoading;
  final String? error;

  const CocktailListState({
    this.drinks = const [],
    this.isLoading = false,
    this.error,
  });

  CocktailListState copyWith({
    List<Cocktail>? drinks,
    bool? isLoading,
    String? error,
  }) {
    return CocktailListState(
      drinks: drinks ?? this.drinks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}