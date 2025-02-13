class ProductImages {
  final String imagePath;
  final String id;
  ProductImages({
    required this.imagePath,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'id': id,
    };
  }

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
      imagePath: json['imagePath'],
      id: json['id'],
    );
  }
}

List<ProductImages> productImgList = [
  ProductImages(
      imagePath: 'assets/images/products/alphonso-mango.png', id: '1'),
  ProductImages(
    imagePath: 'assets/images/products/borccoli.png',
    id: '2',
  ),
  ProductImages(
    imagePath: 'assets/images/products/watermelon.png',
    id: '3',
  ),
  ProductImages(
    imagePath: 'assets/images/products/green-capsicum.png',
    id: '4',
  ),
];
