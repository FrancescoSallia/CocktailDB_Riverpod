class Category {
  final String strCategory;

  Category({required this.strCategory});

  Map<String, dynamic> toJson() => {"strCategory": strCategory};

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(strCategory: json["strCategory"]);
  }
}
