import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/category/views/components/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategorySlider extends StatelessWidget {
  final CategoriesController categoriesController;

  const CategorySlider({super.key, required this.categoriesController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 70.h,
        child: PageView.builder(
          controller: PageController(viewportFraction: 1.2),
          itemCount: categoriesController.categoriesList.length ~/ 4 +
              (categoriesController.categoriesList.length % 4 > 0 ? 1 : 0),
          itemBuilder: (context, pageIndex) {
            int startIndex = pageIndex * 4;
            int endIndex = startIndex + 4;
            endIndex = endIndex > categoriesController.categoriesList.length
                ? categoriesController.categoriesList.length
                : endIndex;

            final currentItems = categoriesController.categoriesList
                .sublist(startIndex, endIndex);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: currentItems.map((category) {
                return FutureBuilder<String>(
                  future: ApiPath.getImageUrl(category.image!.path!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasError) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: AppColors.groceryBorder,
                      );
                    } else {
                      return CategoryCard(
                        imagePath: snapshot.data!,
                        title: category.title!,
                        productCount: category.products!.length.toString(),
                        categoryID: category.id.toString(),
                      );
                    }
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
