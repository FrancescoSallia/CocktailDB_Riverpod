import 'package:riverpod_lerning_flutter/models/cocktail.dart';

class CocktailDetailState {
  final bool isLoading;
  final Cocktail? cocktail;
  final String? error;

  CocktailDetailState({this.isLoading = false, this.cocktail, this.error});

  CocktailDetailState copyWith({
    bool? isLoading,
    Cocktail? cocktail,
    String? error,
  }) {
    return CocktailDetailState(
      isLoading: isLoading ?? this.isLoading,
      cocktail: cocktail ?? this.cocktail,
      error: error ?? this.error,
    );
  }
}
