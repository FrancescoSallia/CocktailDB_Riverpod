import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/providers/cocktail_list_provider.dart';
import 'package:riverpod_lerning_flutter/screens/cocktail_detail_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CocktailListScreen extends ConsumerStatefulWidget {
  final String category;
  const CocktailListScreen({super.key, required this.category});

  @override
  ConsumerState<CocktailListScreen> createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends ConsumerState<CocktailListScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(cocktailList.notifier).cocktailsFromCategory(widget.category);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cocktailsFromCategory = ref.watch(cocktailList).drinks;
    final enabled = ref.watch(cocktailList).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 0, 13),
        title: Text(widget.category),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 35, 3, 18),
      body: Skeletonizer(
        enabled: enabled,
        child: ListView.builder(
          itemCount: cocktailsFromCategory.length,
          itemBuilder: (context, index) {
            final category = cocktailsFromCategory[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CocktailDetailScreen(id: category.idDrink),
                ),
              ),
              child: Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                color: Colors.black,
                // color: Color.fromARGB(255, 236, 138, 231),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child: Image.network(
                            category.strDrinkThumb ??
                                "https://placehold.co/600x400?text=No\nImage",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.strDrink,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        Text(
                          category.strAlcoholic == "Alcoholic"
                              ? "Alcoholic"
                              : "Non Alcoholic",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
