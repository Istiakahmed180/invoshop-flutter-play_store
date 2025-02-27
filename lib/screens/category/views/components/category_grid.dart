import 'package:invoshop/screens/category/models/category_data.dart';
import 'package:invoshop/screens/category/views/components/category_card.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final int maxItems;

  const CategoryGrid({
    super.key,
    required this.maxItems,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount:
          maxItems < categoryData.length ? maxItems : categoryData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final category = categoryData[index];
        return CategoryCard(
          imagePath: category.imagePath,
          title: category.title,
          productCount: category.productCount,
          categoryID: "",
        );
      },
    );
  }
}
