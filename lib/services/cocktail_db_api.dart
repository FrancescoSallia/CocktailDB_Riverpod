import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:riverpod_lerning_flutter/models/category_responce.dart';
import 'package:riverpod_lerning_flutter/models/cocktail.dart';
import 'package:riverpod_lerning_flutter/models/cocktail_responce.dart';
import 'package:riverpod_lerning_flutter/models/states/cocktail_list_state.dart';

class CocktailDbApi {
  CocktailDbApi();

  static var instance = CocktailDbApi();
  static final String baseUrl = "www.thecocktaildb.com";
  final log = Logger();

  Future<CocktailResponce> fetchCocktails(bool isAlcoholic) async {
    final alcoholic = isAlcoholic ? "Alcoholic" : "Non_Alcoholic";
    try {
      final url = Uri.https(baseUrl, "/api/json/v1/1/filter.php", {
        "a": alcoholic,
      });
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);
        return CocktailResponce.fromJson(data);
      } else {
        throw Exception("Fehler beim Laden der Cocktails (fetchCocktails Api)");
      }
    } on Exception catch (e) {
      log.e("Fehler im CocktailDbApi(fetchCocktails) : $e");
      rethrow;
    }
  }

  Future<CategoryResponce> fetchCategories() async {
    try {
      final url = Uri.https(baseUrl, "/api/json/v1/1/list.php", {"c": "list"});
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);
        return CategoryResponce.fromJson(data);
      } else {
        throw Exception(
          "Fehler beim Laden der Cocktails (fetchCategories Api)",
        );
      }
    } on Exception catch (e) {
      log.e("Fehler im CocktailDbApi(fetchCategories) : $e");
      rethrow;
    }
  }

  // https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
  Future<CocktailResponce> cocktailsFromCategory(String category) async {
    try {
      final url = Uri.https(baseUrl, "/api/json/v1/1/filter.php", {
        "c": category,
      });
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);
        return CocktailResponce.fromJson(data);
      } else {
        throw Exception("Fehler beim Laden von Cocktails nach Kategorien");
      }
    } on Exception catch (e) {
      log.e("Error in CocktailDbApi (cocktailFromCategory): $e");
      rethrow;
    }
  }

  Future<Cocktail> fetchCocktailDetail(String id) async {
    try {
      final url = Uri.https(baseUrl, "/api/json/v1/1/lookup.php", {"i": id});
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);
        final drinks = data["drinks"] as List<dynamic>?;

        if (drinks == null || drinks.isEmpty) {
          throw Exception("Keine Cocktaildaten gefunden");
        }

        return Cocktail.fromJson(drinks.first as Map<String, dynamic>);
      } else {
        throw Exception("Fehler beim Laden von CocktailDetail nach id");
      }
    } on Exception catch (e) {
      log.e("Error in CocktailDbApi (cocktailDetail): $e");
      rethrow;
    }
  }

  // www.thecocktaildb.com/api/json/v1/1/search.php?f=a
  Future<CocktailResponce?> searchCocktail(String query) async {
    try {
      final url = Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query.toLowerCase()}',
      );
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);
        final drinks = data['drinks'];

        if (drinks == null) {
          log.w("Keine Cocktails gefunden für '$query'");
          return null; // oder eine leere CocktailResponce zurückgeben
        }

        log.d("api function successfull: $data");
        return CocktailResponce.fromJson(data);
      } else {
        throw Exception("Fehler beim Laden von searchCocktal nach query");
      }
    } on Exception catch (e) {
      log.e("Error in CocktailDbApi (searchCocktail): $e");
      rethrow;
    }
  }
}
