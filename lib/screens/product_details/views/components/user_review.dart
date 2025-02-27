import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UserReviews extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  const UserReviews({super.key, required this.reviews});
  @override
  UserReviewsState createState() => UserReviewsState();
}

class UserReviewsState extends State<UserReviews> {
  bool _showAllReviews = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'User Reviews',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.groceryTitle,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showAllReviews = !_showAllReviews;
                });
              },
              child: Text(
                _showAllReviews ? 'Show Less' : 'See All',
                style: const TextStyle(
                  color: AppColors.groceryPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: List.generate(
            _showAllReviews ? widget.reviews.length : 3,
            (index) {
              final review = widget.reviews[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.groceryBorder,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(review["imageUrl"]),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitleText(title: review["userName"]),
                            const SizedBox(height: 2),
                            Text(
                              review["reviewTime"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.grocerySubTitle,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                if (index < review["rating"].floor()) {
                                  return const Icon(
                                    Icons.star,
                                    color: AppColors.groceryRating,
                                    size: 18,
                                  );
                                } else if (index < review["rating"] &&
                                    index + 1 > review["rating"]) {
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
                            const SizedBox(width: 4),
                            Text(
                              "(${review["rating"]})",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.grocerySubTitle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      review["comment"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.groceryTitle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
