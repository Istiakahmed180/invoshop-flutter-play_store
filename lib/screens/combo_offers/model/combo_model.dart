class ProductCombo {
  final String imagePath;
  final int comboPrice;
  final List<Product> products;

  ProductCombo({
    required this.imagePath,
    required this.comboPrice,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'comboPrice': comboPrice,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory ProductCombo.fromJson(Map<String, dynamic> json) {
    return ProductCombo(
      imagePath: json['imagePath'],
      comboPrice: json['comboPrice'],
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}

class Product {
  final String title;
  final String weight;
  final double price;
  final String category;
  final String imagePath;
  final int quantity;

  Product({
    required this.title,
    required this.weight,
    required this.price,
    required this.category,
    required this.imagePath,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'weight': weight,
      'price': price,
      'category': category,
      'imagePath': imagePath,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      weight: json['weight'],
      price: json['price'].toDouble(),
      category: json['category'],
      imagePath: json['imagePath'],
      quantity: json['quantity'],
    );
  }
}

List<ProductCombo> productComboModel = [
  ProductCombo(
    imagePath: 'assets/images/combo/combo_1.png',
    comboPrice: 70,
    products: [
      Product(
          title: 'Fresh Alphonso Mango',
          weight: '1.2Kg',
          price: 18.22,
          category: 'Mango',
          imagePath: 'assets/images/products/alphonso-mango.png',
          quantity: 2),
      Product(
          title: 'Organic Broccoli',
          weight: '500Gm',
          price: 12.22,
          category: 'Broccoli',
          imagePath: 'assets/images/products/borccoli.png',
          quantity: 3),
      Product(
          title: 'Juicy Watermelon',
          weight: '2Kg',
          price: 4.22,
          category: 'Watermelon',
          imagePath: 'assets/images/products/watermelon.png',
          quantity: 2),
    ],
  ),
  ProductCombo(
    imagePath: 'assets/images/combo/combo_2.png',
    comboPrice: 65,
    products: [
      Product(
          title: 'Green Capsicum',
          weight: '0.8Kg',
          price: 12.22,
          category: 'Capsicum',
          imagePath: 'assets/images/products/green-capsicum.png',
          quantity: 5),
      Product(
          title: 'Fresh Avocado',
          weight: '1.2Kg',
          price: 3.00,
          category: 'Avocado',
          imagePath: 'assets/images/products/fresh-avocado.png',
          quantity: 2),
      Product(
          title: 'Free-range Eggs',
          weight: '6 Pieces',
          price: 3.22,
          category: 'Eggs',
          imagePath: 'assets/images/products/eggs.png',
          quantity: 2),
    ],
  ),
  ProductCombo(
    imagePath: 'assets/images/combo/combo_3.png',
    comboPrice: 80,
    products: [
      Product(
          title: 'Green Capsicum',
          weight: '1.2Kg',
          price: 12.22,
          category: 'Capsicum',
          imagePath: 'assets/images/products/chicken.png',
          quantity: 2),
      Product(
          title: 'Fresh Avocado',
          weight: '1.2Kg',
          price: 14.22,
          category: 'Avocado',
          imagePath: 'assets/images/products/valencia-orange.png',
          quantity: 2),
      Product(
          title: 'Free-range Eggs',
          weight: '8 Pieces',
          price: 20.22,
          category: 'Eggs',
          imagePath: 'assets/images/products/protain-bar.png',
          quantity: 2),
    ],
  ),
];
