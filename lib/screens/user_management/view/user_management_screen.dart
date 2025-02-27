import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/user_management/controller/user_management_controller.dart';
import 'package:invoshop/screens/user_management/view/add_user/add_user_screen.dart';
import 'package:invoshop/screens/user_management/view/edit_user/edit_user_screen.dart';
import 'package:invoshop/screens/user_management/view/roles/roles_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final UserManagementController userManagementController =
      Get.put(UserManagementController());
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    userManagementController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Users"),
      body: Obx(
        () => userManagementController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  _buildDataTable(),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        backgroundColor: AppColors.groceryPrimary,
        onPressed: () {
          final RenderBox renderBox =
              _fabKey.currentContext!.findRenderObject() as RenderBox;
          final buttonPosition = renderBox.localToGlobal(Offset.zero);
          final buttonSize = renderBox.size;
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              buttonPosition.dx,
              buttonPosition.dy - 120,
              buttonPosition.dx + buttonSize.width,
              buttonPosition.dy,
            ),
            items: [
              PopupMenuItem<String>(
                onTap: () {
                  Get.to(const AddUserScreen());
                },
                value: 'Add User',
                child: const Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: AppColors.groceryPrimary,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text('Add User'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                onTap: () {
                  Get.to(const RolesScreen());
                },
                value: 'Add Role',
                child: const Row(
                  children: [
                    Icon(
                      Icons.shield,
                      color: AppColors.groceryPrimary,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text('Add Role'),
                  ],
                ),
              ),
            ],
          );
        },
        child: Icon(
          Icons.add,
          size: 30.w,
          color: AppColors.groceryWhite,
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
      _buildTableHeader("Phone"),
      _buildTableHeader("Email"),
      _buildTableHeader("Role"),
      _buildTableHeader("Status"),
      _buildTableHeader("Action"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return userManagementController.usersList.asMap().entries.map((entry) {
      final index = entry.key;
      final user = entry.value;
      final userFullName =
          [user.firstName ?? "", user.lastName ?? ""].join(" ").trim();
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(Center(
            child: user.image == null
                ? Container(
                    padding: REdgeInsets.all(5),
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                        color: AppColors.groceryBorder,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.groceryRatingGray,
                    ),
                  )
                : FutureBuilder<String>(
                    future: ApiPath.getImageUrl(user.image!.path!),
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
                      return Container(
                        padding: REdgeInsets.all(5),
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                            color: AppColors.groceryBorder,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            imageUrl: snapshot.data ?? "",
                            placeholder: (context, url) =>
                                Image.asset("assets/gif/loading.gif"),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.broken_image,
                              color: AppColors.groceryRatingGray,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )),
          _buildDataCell(userFullName),
          _buildDataCell(user.phone ?? 'N/A'),
          _buildDataCell(
            (user.email ?? "N/A"),
          ),
          _buildDataCell(
              user.roles!.isNotEmpty ? user.roles![0].name ?? "N/A" : "..."),
          _buildDataCell(
            (user.status ?? "N/A"),
          ),
          DataCell(
            OutlinedButton(
              key: actionButtonKey,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                side: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () async {
                final RenderBox renderBox = actionButtonKey.currentContext!
                    .findRenderObject() as RenderBox;
                final buttonPosition = renderBox.localToGlobal(Offset.zero);
                final buttonSize = renderBox.size;
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    buttonPosition.dx,
                    buttonPosition.dy + buttonSize.height,
                    buttonPosition.dx + buttonSize.width,
                    buttonPosition.dy + buttonSize.height + 100,
                  ),
                  items: [
                    PopupMenuItem<String>(
                      onTap: () {
                        Get.to(EditUserScreen(
                          user: user,
                        ));
                      },
                      value: 'Edit',
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.groceryPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      onTap: () {
                        userManagementController.deleteUser(
                            userId: user.id.toString());
                      },
                      value: 'Delete',
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: AppColors.grocerySecondary,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                );
              },
              child: const Text(
                "Action",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.groceryPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
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
