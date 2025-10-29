import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_lerning_flutter/models/category.dart';
import 'package:riverpod_lerning_flutter/services/cocktail_db_api.dart';

final categoryListFromProvider =
    StateNotifierProvider<CategoryListProvider, List<Category>>(
      (ref) => CategoryListProvider(),
    );

class CategoryListProvider extends StateNotifier<List<Category>> {
  CategoryListProvider() : super([]);

  final _api = CocktailDbApi.instance;
  final _log = Logger();

  Future<void> fetchCategories() async {
    try {
      final categories = await _api.fetchCategories();
      state = categories.drinks;
    } on Exception catch (e) {
      _log.e("Fehler im CategoryListProvider (fetchCategories): $e");
    }
  }
}
