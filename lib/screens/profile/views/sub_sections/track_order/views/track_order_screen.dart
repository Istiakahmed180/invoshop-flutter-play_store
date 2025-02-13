import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/common/widgets/sub_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});
  @override
  TrackOrderScreenState createState() => TrackOrderScreenState();
}

class TrackOrderScreenState extends State<TrackOrderScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'Track Order'),
      backgroundColor: AppColors.groceryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.groceryBody,
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.groceryBorder),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Order Id",
                            hintStyle: TextStyle(
                              color: AppColors.grocerySubTitle,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CustomElevatedButton(
                      buttonName: "Track Now",
                      verticalPadding: 11,
                      horizontalPadding: 16,
                      onPressed: () {},
                      buttonTextSize: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SectionTitle(title: 'Wed, 12 Sep'),
                const SubTitle(title: 'ETA: 1 Day'),
                const SubTitle(title: "Order ID: 5t36-83j4  Amt: \$345.00"),
                const SizedBox(height: 16),
                timelineTile(
                  Icons.local_shipping,
                  AppColors.groceryPrimary,
                  "Delivered",
                  "Order#234562 from Invoshop Delivered.",
                  "12:00 PM",
                  isLast: false,
                ),
                timelineTile(
                  Icons.store,
                  AppColors.groceryWarning,
                  "Ready to Pickup",
                  "Order#234562 from Invoshop.",
                  "11:45 AM",
                  isLast: false,
                ),
                timelineTile(
                  Icons.build,
                  AppColors.groceryRating,
                  "Order Processed",
                  "We are preparing your order.",
                  "10:08 AM",
                  isLast: false,
                ),
                timelineTile(
                  Icons.payment,
                  AppColors.groceryInfo,
                  "Payment Confirmed",
                  "Awaiting confirmation...",
                  "10:06 AM",
                  isLast: false,
                ),
                timelineTile(
                  Icons.shopping_cart,
                  AppColors.groceryBorder,
                  "Order Placed",
                  "We have received your order.",
                  "10:04 AM",
                  isLast: true,
                ),
                _buildDivider(),
                const CustomTitleText(title: "Delivery Address"),
                const SubTitle(
                  title: "Jonathon Smith ,",
                ),
                const SubTitle(
                    title:
                        "Home, Work, & Other address\n123 Main St, Apt 202,\nSpringfield, IL 62704"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        const Divider(color: AppColors.groceryBorder),
        SizedBox(height: 5.h),
      ],
    );
  }
}

Widget timelineTile(
    IconData icon, Color color, String title, String subtitle, String time,
    {bool isLast = false}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                const SizedBox(height: 4),
                if (!isLast) ...[
                  Icon(Icons.arrow_upward, color: color, size: 18),
                  DashedLineVertical(
                    color: color,
                    height: 2,
                  ),
                ]
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.groceryTitle)),
                  Text(subtitle, style: const TextStyle(fontSize: 14)),
                  Text(time, style: const TextStyle(fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

class DashedLineVertical extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLineVertical({super.key, this.height = 1, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(height: height, color: color),
      child: Container(
        height: 40,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double height;
  final Color color;

  _DashedLinePainter({required this.height, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = height
      ..style = PaintingStyle.stroke;

    var max = size.height;
    var dashHeight = 6;
    var dashSpace = 6;
    double startY = 0;

    while (startY < max) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
