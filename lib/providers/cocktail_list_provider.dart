import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_lerning_flutter/models/states/cocktail_list_state.dart';
import 'package:riverpod_lerning_flutter/services/cocktail_db_api.dart';

final cocktailList =
    StateNotifierProvider<CocktailListProvider, CocktailListState>(
      (ref) => CocktailListProvider(),
    );

class CocktailListProvider extends StateNotifier<CocktailListState> {
  CocktailListProvider() : super(CocktailListState());

  final _api = CocktailDbApi.instance;
  final _log = Logger();

  Future<void> fetchCocktails({required bool isAlcoholic}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final responce = await _api.fetchCocktails(isAlcoholic);
      state = state.copyWith(
        drinks: responce.drinks,
        isLoading: false,
        error: null,
      );
    } on Exception catch (e) {
      _log.e("Fehler im cocktailListProvider (fetchcocktails) : $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> cocktailsFromCategory(String category) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final responce = await _api.cocktailsFromCategory(category);
      state = state.copyWith(
        drinks: responce.drinks,
        isLoading: false,
        error: null,
      );
    } on Exception catch (e) {
      _log.e(
        "Fehler beim laden der Cocktails von der Kategorie im cocktailListProvider (cocktailsFromCategory): $e",
      );
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> searchCocktail(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(drinks: []);
      return;
    }
    state = state.copyWith(isLoading: true, error: null);

    try {
      final responce = await _api.searchCocktail(query);
      final drinks = responce?.drinks ?? [];

      state = state.copyWith(drinks: drinks, isLoading: false, error: null);
    } on Exception catch (e) {
      _log.e("Fehler beim Suchen: $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void resetError() {
    state = state.copyWith(error: null);
  }
//For Debuging HomeScreen
  void setError(String message) {
    state = state.copyWith(error: message, isLoading: false);
  }
}
