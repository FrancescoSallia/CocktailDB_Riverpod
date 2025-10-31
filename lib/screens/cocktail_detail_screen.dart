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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.error != null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Fehler"),
            content: Text(state.error!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optional: Fehler zurücksetzen, damit Dialog nicht erneut aufpoppt
                  ref.read(cocktailDetailProvider.notifier).resetError();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    });

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.cocktail == null) {
      return const Scaffold(body: Center(child: Text('Keine Daten gefunden')));
    }

    final cocktailDetail = state.cocktail!;

    Map<String, String> ingedientsAndMeasures() => {};

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

    final measures = [
      cocktailDetail.strMeasure1,
      cocktailDetail.strMeasure2,
      cocktailDetail.strMeasure3,
      cocktailDetail.strMeasure4,
      cocktailDetail.strMeasure5,
      cocktailDetail.strMeasure6,
      cocktailDetail.strMeasure7,
      cocktailDetail.strMeasure8,
      cocktailDetail.strMeasure9,
      cocktailDetail.strMeasure10,
      cocktailDetail.strMeasure11,
      cocktailDetail.strMeasure12,
      cocktailDetail.strMeasure13,
      cocktailDetail.strMeasure14,
      cocktailDetail.strMeasure15,
    ];

    final measureText = measures
        .where((mea) => mea != null && mea.trim().isNotEmpty)
        .join(", ");

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              cocktailDetail.strDrinkThumb ??
                  "https://placehold.co/600x400?text=No\nImage",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Alcoholic?"),
                      Text(
                        cocktailDetail.strAlcoholic == "Alcoholic"
                            ? "Yes"
                            : "No",
                      ),
                    ],
                  ),
                  // Text(cocktailDetail.strDrink),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Category: "),
                      Text("${cocktailDetail.strCategory}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Glass:"),
                      Text("${cocktailDetail.strGlass}"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: const Text(
                      "Ingredients",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(ingredients.length, (index) {
                        final ingredient = ingredients[index];
                        final measure = measures[index];

                        // Wir überspringen Einträge, die leer oder null sind
                        if (ingredient == null || ingredient.trim().isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              // Ingredient
                              Expanded(
                                flex: 2,
                                child: Text(
                                  ingredient,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              // Measure (optional)
                              if (measure != null && measure.trim().isNotEmpty)
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    measure,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 5),

                  Center(
                    child: Text(
                      "Instructions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${cocktailDetail.strInstructions}",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Wir erzeugen dynamisch eine Liste aus Ingredient + Measure Paaren
                ],
              ),
            ), //TODO: Weitermachen mit der detailansicht!
            SizedBox(height: 50),
            // Text(cocktailDetail.strVideo),
          ],
        ),
      ),
    );
  }
}
