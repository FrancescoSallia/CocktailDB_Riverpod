class Cocktail {
  final String idDrink;
  final String strDrink;
  final String? strCategory;
  final String? strAlcoholic;
  final String? strGlass;
  // final String strVideo;
  final String? strInstructions;
  final String? strDrinkThumb;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;

  Cocktail({
    required this.idDrink,
    required this.strDrink,
    required this.strCategory,
    required this.strAlcoholic,
    required this.strGlass,
    // required this.strVideo,
    required this.strInstructions,
    required this.strDrinkThumb,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    required this.strIngredient5,
    required this.strIngredient6,
    required this.strIngredient7,
    required this.strIngredient8,
    required this.strIngredient9,
    required this.strIngredient10,
    required this.strIngredient11,
    required this.strIngredient12,
    required this.strIngredient13,
    required this.strIngredient14,
    required this.strIngredient15,
    required this.strMeasure1,
    required this.strMeasure2,
    required this.strMeasure3,
    required this.strMeasure4,
    required this.strMeasure5,
    required this.strMeasure6,
    required this.strMeasure7,
    required this.strMeasure8,
    required this.strMeasure9,
    required this.strMeasure10,
    required this.strMeasure11,
    required this.strMeasure12,
    required this.strMeasure13,
    required this.strMeasure14,
    required this.strMeasure15,
  });

  Map<String, dynamic> toJson() => {
    "strDrink": strDrink,
    "strCategory": strCategory,
    "strAlcoholic": strAlcoholic,
    "strGlass": strGlass,
    // "strVideo" : strVideo,
    "strInstructions": strInstructions,
    "strDrinkThumb": strDrinkThumb,
    "strIngredient1": strIngredient1,
    "strIngredient2": strIngredient2,
    "strIngredient3": strIngredient3,
    "strIngredient4": strIngredient4,
    "strIngredient5": strIngredient5,
    "strIngredient6": strIngredient6,
    "strIngredient7": strIngredient7,
    "strIngredient8": strIngredient8,
    "strIngredient9": strIngredient9,
    "strIngredient10": strIngredient10,
    "strIngredient11": strIngredient11,
    "strIngredient12": strIngredient12,
    "strIngredient13": strIngredient13,
    "strIngredient14": strIngredient14,
    "strIngredient15": strIngredient15,
    "strMeasure1": strMeasure1,
    "strMeasure2": strMeasure2,
    "strMeasure3": strMeasure3,
    "strMeasure4": strMeasure4,
    "strMeasure5": strMeasure5,
    "strMeasure6": strMeasure6,
    "strMeasure7": strMeasure7,
    "strMeasure8": strMeasure8,
    "strMeasure9": strMeasure9,
    "strMeasure10": strMeasure10,
    "strMeasure11": strMeasure11,
    "strMeasure12": strMeasure12,
    "strMeasure13": strMeasure13,
    "strMeasure14": strMeasure14,
    "strMeasure15": strMeasure15,
  };

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      idDrink: json["idDrink"],
      strDrink: json["strDrink"],
      strCategory: json["strCategory"],
      strAlcoholic: json["strAlcoholic"],
      strGlass: json["strGlass"],
      // strVideo: json["strVideo"],
      strInstructions: json["strInstructions"],
      strDrinkThumb: json["strDrinkThumb"],
      strIngredient1: json["strIngredient1"],
      strIngredient2: json["strIngredient2"],
      strIngredient3: json["strIngredient3"],
      strIngredient4: json["strIngredient4"],
      strIngredient5: json["strIngredient5"],
      strIngredient6: json["strIngredient6"],
      strIngredient7: json["strIngredient7"],
      strIngredient8: json["strIngredient8"],
      strIngredient9: json["strIngredient9"],
      strIngredient10: json["strIngredient10"],
      strIngredient11: json["strIngredient11"],
      strIngredient12: json["strIngredient12"],
      strIngredient13: json["strIngredient13"],
      strIngredient14: json["strIngredient14"],
      strIngredient15: json["strIngredient15"],
      strMeasure1: json["strMeasure1"],
      strMeasure2: json["strMeasure2"],
      strMeasure3: json["strMeasure3"],
      strMeasure4: json["strMeasure4"],
      strMeasure5: json["strMeasure5"],
      strMeasure6: json["strMeasure6"],
      strMeasure7: json["strMeasure7"],
      strMeasure8: json["strMeasure8"],
      strMeasure9: json["strMeasure9"],
      strMeasure10: json["strMeasure10"],
      strMeasure11: json["strMeasure11"],
      strMeasure12: json["strMeasure12"],
      strMeasure13: json["strMeasure13"],
      strMeasure14: json["strMeasure14"],
      strMeasure15: json["strMeasure15"],
    );
  }
}
