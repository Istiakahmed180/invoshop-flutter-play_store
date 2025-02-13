import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_text_area.dart';
import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  ReviewFormState createState() => ReviewFormState();
}

class ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  String review = '';

  void _submitReview() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      Fluttertoast.showToast(
          msg: "Review submitted", backgroundColor: AppColors.groceryPrimary);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 400 ? 14 : 16;
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
              const SectionTitle(title: 'Submit Your Review'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTitleText(title: 'Rating'),
                  const SizedBox(width: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: AppColors.groceryRating,
                            size: 20.0,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                hintText: "Write Review",
                maxLines: 3,
                onSaved: (value) => review = value ?? '',
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomElevatedButton(
                  buttonName: "Submit Review",
                  buttonColor: AppColors.groceryPrimary,
                  horizontalPadding: 12,
                  buttonTextSize: fontSize,
                  verticalPadding: 8,
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
