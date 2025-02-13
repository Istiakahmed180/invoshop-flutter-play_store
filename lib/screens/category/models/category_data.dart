class CategoryModel {
  String imagePath;
  String title;
  String productCount;

  CategoryModel(
      {required this.imagePath,
      required this.title,
      required this.productCount});
}

List<CategoryModel> categoryData = [
  CategoryModel(
      imagePath: 'assets/images/category/category_1.png',
      title: 'Fruits & Vegetables',
      productCount: '26'),
  CategoryModel(
      imagePath: 'assets/images/category/category_2.png',
      title: 'Meat & Fish',
      productCount: '36'),
  CategoryModel(
      imagePath: 'assets/images/category/category_3.png',
      title: 'Cooking',
      productCount: '50'),
  CategoryModel(
      imagePath: 'assets/images/category/category_4.png',
      title: 'Sauces & Pickles',
      productCount: '266'),
  CategoryModel(
      imagePath: 'assets/images/category/category_5.png',
      title: 'Dairy & Eggs',
      productCount: '160'),
  CategoryModel(
      imagePath: 'assets/images/category/category_6.png',
      title: 'Candy & Chocolate',
      productCount: '120'),
  CategoryModel(
      imagePath: 'assets/images/category/category_7.png',
      title: 'Vegetables',
      productCount: '30'),
  CategoryModel(
      imagePath: 'assets/images/category/category_8.png',
      title: 'Snacks',
      productCount: '08'),
  CategoryModel(
      imagePath: 'assets/images/category/category_9.png',
      title: 'Beverages',
      productCount: '140'),
  CategoryModel(
      imagePath: 'assets/images/category/fresh-broccoli.png',
      title: 'Baking',
      productCount: '140'),
  CategoryModel(
      imagePath: 'assets/images/category/strawberries.png',
      title: 'Frozen & Canned',
      productCount: '140'),
];
