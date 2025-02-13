import 'package:ai_store/common/controller/vendor_reviews_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/profile/views/sub_sections/reviews/model/my_review_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final VendorReviewsController reviewsController =
      Get.put(VendorReviewsController());
  bool _showAllReviews = false;
  final List<int> _hiddenReviews = [];
  int? _editingIndex;
  String _editingComment = '';
  double _editingRating = 0.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentController.addListener(() {
      _editingComment = _commentController.text;
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'My Reviews',
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
    );
  }

  Widget _buildReviewList() {
    final filteredReviews = myReviews.asMap().entries.where((entry) {
      return !_hiddenReviews.contains(entry.key);
    }).toList();

    if (filteredReviews.isEmpty) {
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
      itemCount: _showAllReviews ? filteredReviews.length : 3,
      itemBuilder: (context, index) {
        if (index >= filteredReviews.length) return const SizedBox.shrink();

        final reviewEntry = filteredReviews[index];
        return _buildReviewItem(reviewEntry.value, reviewEntry.key);
      },
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review, int originalIndex) {
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
          _buildReviewHeader(review, originalIndex),
          const SizedBox(height: 8),
          _buildRatingStars(review["rating"]),
          const SizedBox(height: 8),
          if (_editingIndex == originalIndex)
            _buildEditReviewForm(review)
          else
            Text(
              review["comment"],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grocerySubTitle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewHeader(Map<String, dynamic> review, int index) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.groceryBodyTwo,
          radius: 25,
          backgroundImage: AssetImage(review["imageUrl"]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleText(title: review["productName"]),
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
        ),
        InkWell(
          onTap: () {
            setState(() {
              _editingIndex = index;
              _editingComment = review["comment"];
              _editingRating = review["rating"];
              _commentController.text = _editingComment;
            });
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.groceryBodyTwo,
            child: Icon(Icons.edit,
                size: 20, color: AppColors.groceryPrimary.withOpacity(0.8)),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            setState(() {
              Fluttertoast.showToast(
                  msg: "Deleted Successfully",
                  textColor: AppColors.groceryWhite,
                  backgroundColor: AppColors.groceryPrimary);
              _hiddenReviews.add(index);
            });
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.groceryBodyTwo,
            child: Icon(Icons.delete,
                size: 20, color: AppColors.grocerySecondary.withOpacity(0.8)),
          ),
        )
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return const Icon(
                Icons.star,
                color: AppColors.groceryRating,
                size: 18,
              );
            } else if (index < rating && index + 1 > rating) {
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
          "($rating)",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.grocerySubTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildEditReviewForm(Map<String, dynamic> review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: _commentController,
          cursorColor: AppColors.grocerySubTitle.withOpacity(0.5),
          decoration: InputDecoration(
            labelText: 'Edit your comment',
            labelStyle: const TextStyle(
              color: AppColors.grocerySubTitle,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.groceryBorder,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.groceryBorder,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style: const TextStyle(
            color: AppColors.grocerySubTitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 3,
        ),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _editingRating.floor()
                    ? Icons.star
                    : index < _editingRating && index + 1 > _editingRating
                        ? Icons.star_half
                        : Icons.star_border,
                color: AppColors.groceryRating,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _editingRating = index + 1.0;
                });
              },
            );
          }),
        ),
        Row(
          children: [
            CustomElevatedButton(
              buttonName: "Update",
              onPressed: () {
                setState(() {
                  if (_editingIndex != null) {
                    myReviews[_editingIndex!] = {
                      ...myReviews[_editingIndex!],
                      'comment': _editingComment,
                      'rating': _editingRating,
                    };
                    _editingIndex = null;
                    _editingComment = '';
                    _editingRating = 0.0;
                    _commentController.clear();
                    Fluttertoast.showToast(
                        msg: "Updated Successfully",
                        textColor: AppColors.groceryWhite,
                        backgroundColor: AppColors.groceryPrimary);
                  }
                });
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  _editingIndex = null;
                  _editingComment = '';
                  _editingRating = 0.0;
                  _commentController.clear();
                });
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.groceryPrimary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
