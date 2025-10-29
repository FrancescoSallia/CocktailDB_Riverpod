import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/providers/cocktail_list_provider.dart';
import 'package:riverpod_lerning_flutter/screens/cocktail_home_screen.dart';

class CocktailOverviewScreen extends ConsumerWidget {
  const CocktailOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cocktailList.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 0, 13),
        title: Image.network("https://www.thecocktaildb.com/images/logo.png"),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 35, 3, 18),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 130,
              child: TextButton(
                onPressed: () {
                  //Navigate to without Alcohol Page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CocktailHomeScreen(isAlcoholic: false),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 254, 196, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: const Text(
                  "Without Alcohol",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(
              width: 130,
              child: TextButton(
                onPressed: () {
                  //Navigate to Alcohol Page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CocktailHomeScreen(isAlcoholic: true),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 254, 196, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: const Text(
                  "Alcohol",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
