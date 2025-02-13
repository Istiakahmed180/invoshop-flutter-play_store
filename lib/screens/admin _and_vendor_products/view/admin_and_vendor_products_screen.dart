import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/admin%20_and_vendor_products/controller/admin_and_vendor_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminAndVendorProductsScreen extends StatefulWidget {
  const AdminAndVendorProductsScreen({super.key});

  @override
  State<AdminAndVendorProductsScreen> createState() =>
      _AdminAndVendorProductsScreenState();
}

class _AdminAndVendorProductsScreenState
    extends State<AdminAndVendorProductsScreen> {
  final AdminAndVendorProductsController vendorProductsController =
      Get.put(AdminAndVendorProductsController());
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
      appBar: const CustomAppBar(appBarName: "Products"),
      body: Obx(() {
        if (vendorProductsController.isLoading.value) {
          return const CustomLoading(withOpacity: 0.0);
        }

        if (vendorProductsController.vendorProductList.isEmpty) {
          return _buildNoOrdersMessage();
        }

        return RefreshIndicator(
          backgroundColor: AppColors.groceryBody,
          color: AppColors.groceryPrimary,
          onRefresh: vendorProductsController.getAdminAndVendorProducts,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h),
                  _buildDataTable(),
                  SizedBox(height: 16.h),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: vendorProductsController.isLoading.value,
                  child: const CustomLoading(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNoOrdersMessage() {
    return Center(
      child: Text(
        'No new orders available',
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.groceryPrimary.withOpacity(0.6),
        ),
      ),
    );
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
      _buildTableHeader("Name"),
      _buildTableHeader("Code"),
      _buildTableHeader("Category"),
      _buildTableHeader("Unit"),
      _buildTableHeader("Color Variant"),
      _buildTableHeader("Size Variant"),
      _buildTableHeader("Price"),
      _buildTableHeader("Sale Status"),
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
    return vendorProductsController.vendorProductList
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final product = entry.value;

      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(Center(
            child: FutureBuilder<String>(
              future: _getImageFuture(index, product.image!.path!),
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
          _buildDataCell(product.title ?? 'N/A'),
          _buildDataCell(product.productCode ?? 'N/A'),
          _buildDataCell(
            (product.categories != null && product.categories!.isNotEmpty)
                ? product.categories![0].title ?? "N/A"
                : "N/A",
          ),
          _buildDataCell(product.unit!.name ?? "N/A"),
          _buildDataCell(
            (product.colorVariant != null && product.colorVariant!.isNotEmpty)
                ? product.colorVariant![0].name ?? "N/A"
                : "N/A",
          ),
          _buildDataCell(
            (product.sizeVariant != null && product.sizeVariant!.isNotEmpty)
                ? product.sizeVariant![0].name ?? "N/A"
                : "N/A",
          ),
          DataCell(Center(
            child: Text(
              '\$${product.price ?? '0.00'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.groceryPrimary,
              ),
            ),
          )),
          _buildDataCell(product.status ?? 'N/A'),
        ],
      );
    }).toList();
  }

  DataCell _buildDataCell(String value) {
    return DataCell(
      Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
