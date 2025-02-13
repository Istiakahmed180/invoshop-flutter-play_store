import 'package:ai_store/common/controller/vendor_reviews_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorReviewsScreen extends StatefulWidget {
  const VendorReviewsScreen({super.key});

  @override
  State<VendorReviewsScreen> createState() => _VendorReviewsScreenState();
}

class _VendorReviewsScreenState extends State<VendorReviewsScreen> {
  final VendorReviewsController vendorReviewsController =
      Get.put(VendorReviewsController());
  late Map<int, Future<String>> imageFutures;

  @override
  void initState() {
    super.initState();
    imageFutures = {};
  }

  Future<String> _getImageFuture(int index, String imagePath) {
    return imageFutures.putIfAbsent(
        index, () => ApiPath.getImageUrl(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Reviews"),
        body: Obx(
          () => vendorReviewsController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : vendorReviewsController.reviewsList.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 10.h),
                        _buildDataTable(),
                        SizedBox(height: 12.h),
                      ],
                    )
                  : Center(
                      child: Text(
                        'No reviews available',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.groceryPrimary.withOpacity(0.6),
                        ),
                      ),
                    ),
        ));
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: DataTable(
              showCheckboxColumn: false,
              border: TableBorder(
                borderRadius: BorderRadius.circular(4.r),
                horizontalInside: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.2),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              headingRowColor: WidgetStateProperty.all(
                AppColors.groceryPrimary.withOpacity(0.1),
              ),
              dataRowColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.groceryPrimary.withOpacity(0.2);
                  }
                  return AppColors.groceryPrimary.withOpacity(0.05);
                },
              ),
              horizontalMargin: 15,
              columnSpacing: 40,
              headingRowHeight: 60,
              dataRowMaxHeight: 60,
              dividerThickness: 0.5,
              columns: _buildTableColumns(),
              rows: _buildTableRows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      _buildTableHeader("SL"),
      _buildTableHeader("Image"),
      _buildTableHeader("Product Name"),
      _buildTableHeader("Status"),
      _buildTableHeader("Date"),
      _buildTableHeader("Rating"),
      _buildTableHeader("Comment"),
    ];
  }

  DataColumn _buildTableHeader(String label) {
    return DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.groceryPrimary,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return vendorReviewsController.reviewsList.asMap().entries.map((entry) {
      final index = entry.key;
      final review = entry.value;

      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(Center(
            child: FutureBuilder<String>(
              future: _getImageFuture(index, review.product!.image!.path!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: AppColors.groceryBorder,
                  );
                }
                return CircleAvatar(
                  backgroundColor: AppColors.groceryPrimary.withOpacity(0.05),
                  radius: 25,
                  child: Padding(
                    padding: REdgeInsets.all(4),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/gif/loading.gif",
                      image: snapshot.data!,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Icon(
                        Icons.broken_image,
                        color: AppColors.groceryRatingGray,
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
          DataCell(Center(child: Text(review.product?.title ?? "N/A"))),
          DataCell(Center(child: Text(review.status ?? "N/A"))),
          DataCell(Center(
              child: Text(DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(review.createdAt!))))),
          DataCell(Center(child: Text(review.rating.toString()))),
          DataCell(Center(child: Text(review.content ?? "N/A"))),
        ],
      );
    }).toList();
  }
}
