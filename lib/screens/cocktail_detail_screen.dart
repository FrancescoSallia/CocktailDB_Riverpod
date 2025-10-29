import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/providers/cocktail_detail_provider.dart';

class CocktailDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const CocktailDetailScreen({super.key, required this.id});

  @override
  ConsumerState<CocktailDetailScreen> createState() =>
      _CocktailDetailScreenState();
}

class _CocktailDetailScreenState extends ConsumerState<CocktailDetailScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(cocktailDetailProvider.notifier).fetchCocktailDetail(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cocktailDetailProvider);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.cocktail == null) {
      return const Scaffold(body: Center(child: Text('Keine Daten gefunden')));
    }

    final cocktailDetail = state.cocktail!;

    final ingredients = [
      cocktailDetail.strIngredient1,
      cocktailDetail.strIngredient2,
      cocktailDetail.strIngredient3,
      cocktailDetail.strIngredient4,
      cocktailDetail.strIngredient5,
      cocktailDetail.strIngredient6,
      cocktailDetail.strIngredient7,
      cocktailDetail.strIngredient8,
      cocktailDetail.strIngredient9,
      cocktailDetail.strIngredient10,
      cocktailDetail.strIngredient11,
      cocktailDetail.strIngredient12,
      cocktailDetail.strIngredient13,
      cocktailDetail.strIngredient14,
      cocktailDetail.strIngredient15,
    ];

    // Filter null und leere Strings
    final ingredientText = ingredients
        .where((ing) => ing != null && ing.trim().isNotEmpty)
        .join(", ");

    Text("Ingredients: $ingredientText");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 0, 13),
        title: Text(cocktailDetail.strDrink),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 35, 3, 18),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            cocktailDetail.strDrinkThumb ??
                "https://placehold.co/600x400?text=No\nImage",
          ),
          Text(cocktailDetail.strDrink),
          Text("Category: ${cocktailDetail.strCategory}"),
          Text("${cocktailDetail.strAlcoholic}"),
          Text("glass: ${cocktailDetail.strGlass}"),
          Text("Instructions: ${cocktailDetail.strInstructions}"),

          Text("Ingedients:"),
          Text(ingredientText), //TODO: Weitermachen mit der detailansicht!
          
        ],
      ),
    );
  }
}
