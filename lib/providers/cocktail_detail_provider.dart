import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_lerning_flutter/models/states/cocktail_detail_state.dart';
import 'package:riverpod_lerning_flutter/services/cocktail_db_api.dart';

final cocktailDetailProvider =
    StateNotifierProvider<CocktailDetailProvider, CocktailDetailState>(
      (ref) => CocktailDetailProvider(),
    );

class CocktailDetailProvider extends StateNotifier<CocktailDetailState> {
  CocktailDetailProvider() : super(CocktailDetailState());

  final _api = CocktailDbApi.instance;
  final _log = Logger();

  Future<void> fetchCocktailDetail(String id) async {
    state = state.copyWith(isLoading: true);

    try {
      final responce = await _api.fetchCocktailDetail(id);
      state = state.copyWith(cocktail: responce, isLoading: false, error: null);
    } on Exception catch (e) {
      _log.e("Error in cocktailDetailPovider (fetchCocktailDetail): $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
