import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/providers/category_list_provider.dart';
import 'package:riverpod_lerning_flutter/providers/cocktail_list_provider.dart';
import 'package:riverpod_lerning_flutter/screens/cocktail_list_screen.dart';

class CocktailHomeScreen extends ConsumerStatefulWidget {
  final bool isAlcoholic;
  const CocktailHomeScreen({super.key, required this.isAlcoholic});

  @override
  ConsumerState<CocktailHomeScreen> createState() => _CocktailHomeScreenState();
}

class _CocktailHomeScreenState extends ConsumerState<CocktailHomeScreen> {
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
  Widget build(BuildContext context) {
    final cocktails = ref.watch(cocktailList);
    final categories = ref.watch(categoryListFromProvider);
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
            SizedBox(height: 20),
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 6,
              ),
              child: Text(
                "Explore Cocktails",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 240,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                      left: index == 0 ? 15 : 25,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 236, 138, 231),
                      color: Color.fromARGB(
                        255,
                        14,
                        1,
                        7,
                      ).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: AlignmentGeometry.bottomLeft,
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(height: 100),
                        Positioned(
                          left: 80,
                          bottom: 120,
                          child: Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              Container(
                                height: 160,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                    255,
                                    236,
                                    138,
                                    231,
                                  ).withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    100,
                                  ),
                                  child: Image.network(
                                    "https://www.thecocktaildb.com/images/media/drink/yk70e31606771240.jpg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Title $index",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Category $index",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Alcoholic ",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
    final state = ref.watch(cocktailList);
    final notifier = ref.read(cocktailList.notifier);

    return SearchAnchor.bar(
      barHintText: "Search cocktails...",
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
            },
          );
        });
      },
    );
    //   return SearchAnchor(
    //     builder: (BuildContext context, SearchController controller) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //         child: SizedBox(
    //           height: 50,
    //           child: SearchBar(
    //             controller: controller,
    //             textStyle: WidgetStatePropertyAll<TextStyle>(
    //               TextStyle(color: Colors.black),
    //             ),
    //             hintStyle: WidgetStatePropertyAll<TextStyle>(
    //               TextStyle(color: Colors.black),
    //             ),
    //             hintText: "Search by Cocktail name, Category...",
    //             backgroundColor: WidgetStatePropertyAll(Colors.white),
    //             padding: const WidgetStatePropertyAll<EdgeInsets>(
    //               EdgeInsets.symmetric(horizontal: 16.0),
    //             ),
    //             onTap: () async {
    //               controller.openView();
    //               await notifier.searchCocktail(
    //                 controller.text,
    //               ); // TODO: schau dir onchange und ontap an die funktionen !
    //             },
    //             onChanged: (value) async {
    //               controller.openView();
    //               await notifier.searchCocktail(value); // ruft die API auf
    //             },

    //             leading: const Icon(Icons.search, color: Colors.black),
    //             trailing: <Widget>[
    //               Tooltip(
    //                 message: 'Change brightness mode',
    //                 child: IconButton(
    //                   isSelected: true,
    //                   onPressed: () {
    //                     controller.clear();
    //                   },
    //                   icon: const Icon(Icons.cancel, color: Colors.black),
    //                   selectedIcon: const Icon(Icons.cancel, color: Colors.black),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //     suggestionsBuilder: (BuildContext context, SearchController controller) {
    //       return [
    //         Consumer(
    //           builder: (context, ref, _) {
    //             final state = ref.watch(cocktailList);
    //             final cocktails = state.drinks;

    //             if (state.isLoading) {
    //               return const Center(
    //                 child: Padding(
    //                   padding: EdgeInsets.all(16.0),
    //                   child: CircularProgressIndicator(),
    //                 ),
    //               );
    //             }

    //             if (cocktails.isEmpty) {
    //               return const Padding(
    //                 padding: EdgeInsets.all(16.0),
    //                 child: Text("Keine Cocktails gefunden"),
    //               );
    //             }

    //             return Column(
    //               children: List.generate(cocktails.length, (int index) {
    //                 final cocktail = cocktails[index];
    //                 return ListTile(
    //                   title: Text(cocktail.strDrink),
    //                   trailing: ClipRRect(
    //                     borderRadius: BorderRadius.circular(100),
    //                     child: Image.network(cocktail.strDrinkThumb ?? ""),
    //                   ),
    //                   onTap: () {
    //                     controller.closeView(cocktail.strDrink);
    //                   },
    //                 );
    //               }),
    //             );
    //           },
    //         ),
    //       ];
    //     },
    //   );
  }
}
