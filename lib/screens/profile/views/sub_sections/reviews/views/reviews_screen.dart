import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:invoshop/common/controller/reviews_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/reviews/model/review_model.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewsController reviewsController = Get.put(ReviewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Reviews"),
      body: Obx(
        () => reviewsController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    Expanded(child: _buildReviewList()),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'My Reviews',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.groceryTitle,
      ),
    );
  }

  Widget _buildReviewList() {
    if (reviewsController.reviewsList.isEmpty) {
      return const Center(
        child: Text(
          "No Reviews Found",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.grocerySubTitle,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: reviewsController.reviewsList.length,
      itemBuilder: (context, index) {
        final ReviewData review = reviewsController.reviewsList[index];
        return _buildReviewItem(review: review);
      },
    );
  }

  Widget _buildReviewItem({required ReviewData review}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.groceryWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grocerySubTitle.withOpacity(0.2),
          ),
        ],
        border: Border.all(
          color: AppColors.groceryBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildReviewHeader(review: review)),
              _buildRatingStars(review: review),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.content ?? "N/A",
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.grocerySubTitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewHeader({required ReviewData review}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.groceryBodyTwo,
          radius: 25,
          backgroundImage: AssetImage("assets/images/products/borccoli.png"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleText(title: review.product!.title ?? "N/A"),
              const SizedBox(height: 2),
              Text(
                DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(review.createdAt.toString())),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grocerySubTitle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingStars({required ReviewData review}) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < review.rating!.floor()) {
              return const Icon(
                Icons.star,
                color: AppColors.groceryRating,
                size: 18,
              );
            } else if (index < review.rating! && index + 1 > review.rating!) {
              return const Icon(
                Icons.star_half,
                color: AppColors.groceryRating,
                size: 18,
              );
            } else {
              return const Icon(
                Icons.star_border,
                color: AppColors.groceryRatingGray,
                size: 18,
              );
            }
          }),
        ),
      ],
    );
  }
}
