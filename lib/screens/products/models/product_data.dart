class Product {
  final String imagePath;
  final String weight;
  final String category;
  final String parentCategory;
  final String title;
  final double rating;
  final double price;
  final double? previousPrice;
  final int discountPercentage;
  final String id;
  int? quantity;
  final String brand;
  final String size;
  final String sku;
  final String availability;
  final String expirationDate;
  final List<String> ingredients;

  Product({
    required this.imagePath,
    required this.category,
    required this.weight,
    required this.parentCategory,
    required this.title,
    required this.rating,
    required this.price,
    this.previousPrice,
    this.discountPercentage = 0,
    required this.id,
    required this.quantity,
    required this.brand,
    required this.size,
    required this.sku,
    required this.availability,
    required this.expirationDate,
    required this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'weight': weight,
      'category': category,
      'parentCategory': parentCategory,
      'title': title,
      'rating': rating,
      'price': price,
      'previousPrice': previousPrice,
      'discountPercentage': discountPercentage,
      'id': id,
      'quantity': quantity,
      'brand': brand,
      'size': size,
      'sku': sku,
      'availability': availability,
      'expirationDate': expirationDate,
      'ingredients': ingredients,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json['imagePath'],
      weight: json['weight'],
      category: json['category'],
      parentCategory: json['parentCategory'],
      title: json['title'],
      rating: json['rating'].toDouble(),
      price: json['price'].toDouble(),
      previousPrice: (json['previousPrice'] as num?)?.toDouble(),
      discountPercentage: json['discountPercentage'].toInt(),
      id: json['id'],
      quantity: json['quantity'],
      brand: json['brand'],
      size: json['size'],
      sku: json['sku'],
      availability: json['availability'],
      expirationDate: json['expirationDate'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}

List<Product> productList = [
  Product(
    imagePath: 'assets/images/products/alphonso-mango.png',
    weight: '500Gm',
    category: 'Fruits & Vegetables',
    parentCategory: 'Strawberry',
    title: 'Alphonso mango',
    rating: 4.5,
    price: 18.22,
    previousPrice: 22.22,
    discountPercentage: 10,
    id: '1',
    quantity: 0,
    brand: 'Tropical Fruit Co',
    size: '1 kg',
    sku: 'SKU12345',
    availability: 'In Stock',
    expirationDate: '2024-09-01',
    ingredients: ['Mango'],
  ),
  Product(
    imagePath: 'assets/images/products/borccoli.png',
    category: 'Vegetables',
    weight: '1Kg',
    parentCategory: 'Fresh Broccoli',
    title: 'Fresh Broccoli',
    rating: 5,
    price: 12.22,
    discountPercentage: 15,
    id: '2',
    quantity: 5,
    brand: 'Green Farms',
    size: '500 g',
    sku: 'SKU12346',
    availability: 'In Stock',
    expirationDate: '2024-09-10',
    ingredients: ['Broccoli'],
  ),
  Product(
    imagePath: 'assets/images/products/watermelon.png',
    weight: '1.5Kg',
    category: 'Meat & Fish',
    parentCategory: 'Natural Guava',
    title: 'Fresh Watermelon',
    rating: 3,
    price: 4.22,
    previousPrice: 6.22,
    discountPercentage: 15,
    id: '3',
    quantity: 0,
    brand: 'Juicy Fresh',
    size: '5 kg',
    sku: 'SKU12347',
    availability: 'Out of Stock',
    expirationDate: '2024-08-30',
    ingredients: ['Watermelon'],
  ),
  Product(
    imagePath: 'assets/images/products/green-capsicum.png',
    weight: '1Kg',
    category: 'Cooking',
    parentCategory: 'Bell Peppers',
    title: 'Green Capsicum',
    rating: 5,
    price: 12.22,
    previousPrice: 14.22,
    id: '4',
    quantity: 0,
    brand: 'Veggie Delight',
    size: '250 g',
    sku: 'SKU12348',
    availability: 'In Stock',
    expirationDate: '2024-09-05',
    ingredients: ['Capsicum'],
  ),
  Product(
    imagePath: 'assets/images/products/fresh-avocado.png',
    weight: '0.5Kg',
    category: 'Meat & Fish',
    parentCategory: 'Rich Peaches',
    title: 'Halves of Fresh Avocado',
    rating: 4.5,
    price: 3.22,
    previousPrice: 5.22,
    id: '5',
    quantity: 0,
    brand: 'Avocado Org',
    size: '1 piece',
    sku: 'SKU12349',
    availability: 'In Stock',
    expirationDate: '2024-09-03',
    ingredients: ['Avocado'],
  ),
  Product(
    imagePath: 'assets/images/products/eggs.png',
    weight: '8 piece',
    category: 'Dairy & Eggs',
    parentCategory: 'Rich Peaches',
    title: 'Brown Chicken Eggs',
    rating: 4.5,
    price: 3.22,
    previousPrice: 5.22,
    id: '6',
    quantity: 0,
    brand: 'Egg Brand',
    size: '12 pieces',
    sku: 'SKU12350',
    availability: 'In Stock',
    expirationDate: '2024-09-12',
    ingredients: ['Eggs'],
  ),
  Product(
    imagePath: 'assets/images/products/chicken.png',
    weight: '1Kg',
    category: 'Breakfast',
    parentCategory: 'Fresh Meats',
    title: 'Fresh Chicken',
    rating: 5,
    price: 12.22,
    previousPrice: 14.22,
    id: '7',
    quantity: 0,
    brand: 'Meat Brand',
    size: '1 kg',
    sku: 'SKU12351',
    availability: 'In Stock',
    expirationDate: '2024-09-05',
    ingredients: ['Chicken'],
  ),
  Product(
    imagePath: 'assets/images/products/valencia-orange.png',
    weight: '1Kg',
    category: 'Breakfast',
    parentCategory: 'Plum Orange',
    title: 'Valencia Orange',
    rating: 3.5,
    price: 14.22,
    previousPrice: 16.22,
    id: '8',
    quantity: 0,
    brand: 'Citrus World',
    size: '1 kg',
    sku: 'SKU12352',
    availability: 'In Stock',
    expirationDate: '2024-09-02',
    ingredients: ['Orange'],
  ),
  Product(
    imagePath: 'assets/images/products/protain-bar.png',
    weight: '0.8Kg',
    category: 'Snacks',
    parentCategory: 'Protein Bars',
    title: 'Yogabar Baked Brownie Protein Bar',
    rating: 5,
    price: 20.22,
    previousPrice: 34.22,
    discountPercentage: 12,
    id: '9',
    quantity: 0,
    brand: 'Yogabar',
    size: '60 g',
    sku: 'SKU12353',
    availability: 'In Stock',
    expirationDate: '2024-12-01',
    ingredients: ['Brownie', 'Protein'],
  ),
  Product(
    imagePath: 'assets/images/products/cheese.png',
    weight: '1Kg',
    category: 'Sauces & Pickles',
    parentCategory: 'Cheese',
    title: 'Kraft Easy Mac Original Macaroni & Cheese',
    rating: 4.5,
    price: 30.22,
    previousPrice: 42.22,
    discountPercentage: 30,
    id: '10',
    quantity: 0,
    brand: 'Kraft',
    size: '205 g',
    sku: 'SKU12354',
    availability: 'In Stock',
    expirationDate: '2025-01-01',
    ingredients: ['Macaroni', 'Cheese'],
  ),
  Product(
    imagePath: 'assets/images/products/red-rice.png',
    weight: '1.5Kg',
    category: 'Baking',
    parentCategory: 'Rice',
    title: 'Seeds of Change Organic Red Rice',
    rating: 4.5,
    price: 20.22,
    previousPrice: 34.22,
    discountPercentage: 25,
    id: '11',
    quantity: 0,
    brand: 'Seeds of Change',
    size: '250 g',
    sku: 'SKU12355',
    availability: 'In Stock',
    expirationDate: '2024-12-31',
    ingredients: ['Red Rice'],
  ),
  Product(
    imagePath: 'assets/images/products/mango.png',
    weight: '1Kg',
    category: 'Frozen & Canned',
    parentCategory: 'Green Beans',
    title: 'Alphonso Mango',
    rating: 4.5,
    price: 18.22,
    previousPrice: 34.22,
    discountPercentage: 25,
    id: '12',
    quantity: 0,
    brand: 'Tropical Fruit Co.',
    size: '1 kg',
    sku: 'SKU12356',
    availability: 'In Stock',
    expirationDate: '2024-09-01',
    ingredients: ['Mango'],
  ),
  Product(
    imagePath: 'assets/images/products/coffe.png',
    weight: '1.5Kg',
    category: 'Beverages',
    parentCategory: 'Creamer',
    title: 'Coffee-Mate Creamer',
    rating: 4.5,
    price: 3.99,
    previousPrice: 7.22,
    discountPercentage: 25,
    id: '13',
    quantity: 0,
    brand: 'Nestlé',
    size: '450 g',
    sku: 'SKU12357',
    availability: 'In Stock',
    expirationDate: '2024-12-15',
    ingredients: ['Creamer'],
  ),
  Product(
    imagePath: 'assets/images/products/itembe.png',
    weight: '1Kg',
    category: 'Beverages',
    parentCategory: 'Protein Drinks',
    title: 'Protein Drink',
    rating: 4.5,
    price: 2.99,
    previousPrice: 5.22,
    discountPercentage: 40,
    id: '14',
    quantity: 0,
    brand: 'Protein Brand',
    size: '500 ml',
    sku: 'SKU12358',
    availability: 'In Stock',
    expirationDate: '2024-12-10',
    ingredients: ['Protein', 'Water'],
  ),
  Product(
    imagePath: 'assets/images/products/ice-cream.png',
    weight: '0.5Kg',
    category: 'Dairy & Eggs',
    parentCategory: 'Yogurt',
    title: 'Astro Original Yogurt',
    rating: 4.5,
    price: 5.99,
    previousPrice: 8.00,
    discountPercentage: 35,
    id: '15',
    quantity: 0,
    brand: 'Astro',
    size: '750 g',
    sku: 'SKU12359',
    availability: 'In Stock',
    expirationDate: '2024-11-30',
    ingredients: ['Milk', 'Sugar', 'Cream'],
  ),
];
