import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyReviewForm extends StatefulWidget {
  final String initialComment;
  final int initialRating;

  const MyReviewForm({
    super.key,
    required this.initialComment,
    required this.initialRating,
  });

  @override
  ReviewFormState createState() => ReviewFormState();
}

class ReviewFormState extends State<MyReviewForm> {
  final _formKey = GlobalKey<FormState>();
  late int _rating;
  late String _comment;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _comment = widget.initialComment;
  }

  void _submitReview() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Fluttertoast.showToast(
          msg: "Review updated", backgroundColor: AppColors.groceryPrimary);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.groceryBody,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: AppColors.groceryBorder,
          width: 1.0,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Update Your Review'),
              Row(
                children: [
                  const CustomTitleText(title: 'Rating'),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: AppColors.groceryRating,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              TextFormField(
                initialValue: _comment,
                cursorColor: AppColors.grocerySubTitle.withOpacity(0.5),
                decoration: InputDecoration(
                  labelText: 'Write Review',
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
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
                onSaved: (value) => _comment = value ?? '',
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomElevatedButton(
                  buttonName: "Update Review",
                  buttonBorderRadius: 8,
                  buttonColor: AppColors.groceryPrimary,
                  horizontalPadding: 10,
                  verticalPadding: 8,
                  buttonTextSize: 14,
                  onPressed: () {
                    _submitReview();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
