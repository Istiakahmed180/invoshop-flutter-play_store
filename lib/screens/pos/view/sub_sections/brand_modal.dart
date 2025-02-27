import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/brand/models/brands_model.dart';
import 'package:invoshop/screens/pos/controller/pos_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BrandModal extends StatelessWidget {
  const BrandModal({super.key});

  static void show(BuildContext context, PosController posController) {
    showDialog(
      context: context,
      builder: (context) => BrandModalDialog(
        posController: posController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class BrandModalDialog extends StatelessWidget {
  final PosController posController;

  const BrandModalDialog({super.key, required this.posController});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
      elevation: 0,
      backgroundColor: AppColors.groceryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      child: Padding(
        padding: REdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBrandModalHeader(context),
            SizedBox(height: 10.h),
            Expanded(child: _buildBrandGrid(context, posController)),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandModalHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Brands",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
        ),
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: AppColors.grocerySecondary, width: 1),
            ),
            padding: REdgeInsets.all(7),
            child: SvgPicture.asset(
              "assets/icons/close_icon.svg",
              width: 10,
              colorFilter: const ColorFilter.mode(
                AppColors.grocerySecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandGrid(BuildContext context, PosController posController) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.1,
      ),
      itemCount: posController.brandList.length,
      itemBuilder: (context, index) {
        final BrandsData brand = posController.brandList[index];
        return _buildBrandItem(context, brand);
      },
    );
  }

  Widget _buildBrandItem(BuildContext context, BrandsData brand) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: () async {
        posController.brandId.value = brand.id ?? 0;
        Get.back();
        posController.getBrandIdByProducts();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.groceryBorder,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
              future: ApiPath.getImageUrl(brand.image!.path ?? ""),
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
                return CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.2,
                  imageUrl: snapshot.data ?? "",
                  placeholder: (context, url) =>
                      Image.asset("assets/gif/loading.gif"),
                  errorWidget: (context, url, error) => Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: AppColors.groceryRatingGray.withAlpha(25)),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.groceryRatingGray,
                    ),
                  ),
                );
              },
            ),
            Text(
              brand.title!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
