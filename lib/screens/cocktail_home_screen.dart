import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/models/cocktail.dart';
import 'package:riverpod_lerning_flutter/providers/category_list_provider.dart';
import 'package:riverpod_lerning_flutter/providers/cocktail_list_provider.dart';
import 'package:riverpod_lerning_flutter/screens/cocktail_detail_screen.dart';
import 'package:riverpod_lerning_flutter/screens/cocktail_list_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CocktailHomeScreen extends ConsumerStatefulWidget {
  final bool isAlcoholic;
  const CocktailHomeScreen({super.key, required this.isAlcoholic});

  @override
  ConsumerState<CocktailHomeScreen> createState() => _CocktailHomeScreenState();
}

class _CocktailHomeScreenState extends ConsumerState<CocktailHomeScreen> {
  final SearchController _controller = SearchController();

  @override
  void initState() {
    super.initState();

    // 👇 Beim Start einmalig API aufrufen
    Future.microtask(() {
      ref
          .read(cocktailList.notifier)
          .fetchCocktails(isAlcoholic: widget.isAlcoholic);
      ref.read(categoryListFromProvider.notifier).fetchCategories();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cocktailList);

    // 🧩 Wenn ein Fehler da ist, zeig einen Dialog
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
                  ref.read(cocktailList.notifier).resetError();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Drawer(backgroundColor: Color.fromARGB(255, 29, 0, 13)),
      backgroundColor: const Color.fromARGB(255, 35, 3, 18),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 0, 13),
        title: Image.network("https://www.thecocktaildb.com/images/logo.png"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5,
              ),
              child: Text(
                "I'd like to have...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            _searchbar(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 6,
              ),
              child: Text(
                "Category's",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            categoryList(),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: Text(
                "Explore Drink's",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(
              // height: 400,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 14,
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.vertical,
                itemCount: state.drinks.length,
                itemBuilder: (context, index) {
                  final cocktail = state.drinks[index];

                  if (state.isLoading) {
                    return Skeletonizer(
                      //Beim Laden den Skeletonizer anzeigen lassen
                      enabled: true,
                      child: exploreListItem(context, cocktail, index),
                    );
                  } else {
                    final cocktail = state.drinks[index];
                    return exploreListItem(context, cocktail, index);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //For Debbuging
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ref
      //         .read(cocktailList.notifier)
      //         .setError("Test-Fehler: Verbindung fehlgeschlagen");
      //   },
      //   child: Icon(Icons.bug_report),
      // ),
    );
  }

  GestureDetector exploreListItem(
    BuildContext context,
    Cocktail cocktail,
    int index,
  ) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CocktailDetailScreen(id: cocktail.idDrink),
        ),
      ),
      child: Container(
        width: 230,
        // padding: EdgeInsets.all(8),
        // margin: EdgeInsets.only(left: 25, right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              cocktail.strDrinkThumb ??
                  "https://placehold.co/600x400?text=No\nImage",
            ),
            fit: BoxFit.cover,
          ),
          // color: Color.fromARGB(255, 236, 138, 231),
          color: Color.fromARGB(255, 14, 1, 7).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: AlignmentGeometry.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white.withValues(alpha: 0.2),
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 236, 138, 231),
                          ),
                        ),
                        child: Text(
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          cocktail.strDrink,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text(
                  //   cocktail.strCategory ?? "(No Category)",
                  //   style: TextStyle(
                  //     // color: Colors.black,
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 20,
                  //   ),
                  // ),
                  // Text(
                  //   cocktail.strAlcoholic != null
                  //       ? cocktail.strAlcoholic == "Alcoholic"
                  //             ? "Alcoholic"
                  //             : "Non Alcoholic"
                  //       : "Unknown",
                  //   style: TextStyle(
                  //     // color: Colors.black,
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 20,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox categoryList() {
    final categories = ref.watch(categoryListFromProvider);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CocktailListScreen(category: category.strCategory),
              ),
            ),
            child: SizedBox(
              width: 150,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(
                  left: index == 0 ? 15 : 10,
                  right: index == categories.length - 1 ? 15 : 10,
                ),
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 236, 138, 231),
                  color: Color.fromARGB(255, 254, 196, 58),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    category.strCategory,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SearchAnchor _searchbar() {
    return SearchAnchor.bar(
      searchController: _controller,
      barHintText: "Search cocktails...",
      barTrailing: [
        IconButton(
          onPressed: () {
            _controller.clear();
            ref
                .read(cocktailList.notifier)
                .fetchCocktails(isAlcoholic: widget.isAlcoholic);
          },
          icon: Icon(Icons.cancel),
        ),
      ],
      onChanged: (value) async {
        if (value.isEmpty) return;
        await ref.read(cocktailList.notifier).searchCocktail(value);
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final state = ref.watch(cocktailList);
        final cocktails = state.drinks;

        if (state.isLoading) {
          return [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          ];
        }

        if (cocktails.isEmpty) {
          return [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Keine Cocktails gefunden"),
            ),
          ];
        }

        return List.generate(cocktails.length, (int index) {
          final cocktail = cocktails[index];
          return ListTile(
            title: Text(cocktail.strDrink),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                cocktail.strDrinkThumb ?? "",
                width: 50,
                height: 50,
              ),
            ),
            onTap: () {
              controller.closeView(cocktail.strDrink);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CocktailDetailScreen(id: cocktail.idDrink),
                ),
              );
            },
          );
        });
      },
    );
  }
}
