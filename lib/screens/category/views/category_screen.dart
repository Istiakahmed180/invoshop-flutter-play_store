import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/common/widgets/common_header.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/products/views/filtered_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => categoriesController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Column(
                children: [
                  const CommonHeader(),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: categoriesController.categoriesList.isNotEmpty
                        ? GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.5,
                            ),
                            itemCount:
                                categoriesController.categoriesList.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categoriesController.categoriesList[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => FilteredProductsScreen(
                                        categoryID: category.id.toString(),
                                        categoryTitle: category.title!,
                                        requestType: "Category",
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.groceryBodyTwo,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.grocerySubTitle
                                            .withOpacity(0.2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: AppColors.groceryBorder,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: REdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FutureBuilder<String>(
                                          future: ApiPath.getImageUrl(
                                              category.image!.path!),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const SizedBox();
                                            }
                                            if (snapshot.hasError) {
                                              return const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: AppColors.groceryBorder,
                                              );
                                            }
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: FadeInImage.assetNetwork(
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    "assets/gif/loading.gif",
                                                image: snapshot.data!,
                                                imageErrorBuilder: (context,
                                                        error, stackTrace) =>
                                                    const Icon(
                                                  Icons.broken_image,
                                                  color: AppColors
                                                      .groceryRatingGray,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomTitleText(
                                                title: category.title!,
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "${category.products!.length} Products",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.grocerySubTitle,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'No categories available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.groceryRatingGray,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
