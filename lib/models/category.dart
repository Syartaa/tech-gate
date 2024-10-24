enum CategoryName {
  Telefona,
  Laptop,
  Smartwatch,
  Tv,
  Elektro,
}

class Category {
  final String thumbnailImage; // Image for category display
  final String fullImage; // Image for use in the category product screen
  final CategoryName categoryName;

  Category({
    required this.thumbnailImage,
    required this.fullImage,
    required this.categoryName,
  });
}
