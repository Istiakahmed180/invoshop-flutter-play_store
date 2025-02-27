import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/pos/controller/pos_bills_controller.dart';
import 'package:invoshop/screens/pos/controller/pos_make_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PosMakePayment extends StatefulWidget {
  const PosMakePayment({super.key});

  @override
  State<PosMakePayment> createState() => _PosMakePaymentState();
}

class _PosMakePaymentState extends State<PosMakePayment> {
  final PosMakePaymentController paymentController =
      Get.put(PosMakePaymentController());
  final PosBillsController posBillsController = Get.put(PosBillsController());

  @override
  void initState() {
    super.initState();
    paymentController.payableAmountController.text =
        posBillsController.totalSubtotals.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Make Payment"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Payable Amount"),
                      SizedBox(height: 5.h),
                      TextFormField(
                        controller: paymentController.payableAmountController,
                        readOnly: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Paid Amount"),
                      SizedBox(height: 5.h),
                      TextFormField(
                        controller: paymentController.paidAmountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "0.00",
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            paymentController.calculateChangeAmount();
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Change Amount"),
                      SizedBox(height: 5.h),
                      TextFormField(
                        controller: paymentController.changeAmountController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "0.00",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Payment Date"),
                      SizedBox(height: 5.h),
                      CustomDatePicker(
                        initialDate: DateTime.now(),
                        onDateSelected: (DateTime date) {
                          paymentController.selectedDate.value = date;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Payment Type"),
                      SizedBox(height: 5.h),
                      CustomDropdownField(
                        hintText: "Select Type",
                        dropdownItems: const ["Cash", "Bank", "Card"],
                        onChanged: (value) {
                          paymentController.paymentType.value = value ?? "";
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Visibility(
                        visible: paymentController.paymentType.value == "Bank",
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(text: "Account Number"),
                                SizedBox(height: 5.h),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      paymentController.accountNumberController,
                                  decoration: const InputDecoration(
                                    hintText: "XXXX XXXX XXXX XXXX",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(text: "Transaction ID"),
                                SizedBox(height: 5.h),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller:
                                      paymentController.transactionIdController,
                                  decoration: const InputDecoration(
                                    hintText: "XXXX XXXX XXXX XXXX",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        )),
                  ),
                  Obx(
                    () => Visibility(
                        visible: paymentController.paymentType.value == "Card",
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(text: "Card Number"),
                                SizedBox(height: 5.h),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      paymentController.cardNumberController,
                                  decoration: const InputDecoration(
                                    hintText: "XXXX XXXX XXXX XXXX",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(text: "Transaction ID"),
                                SizedBox(height: 5.h),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller:
                                      paymentController.transactionIdController,
                                  decoration: const InputDecoration(
                                    hintText: "XXXX XXXX XXXX XXXX",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(text: "Note"),
                      SizedBox(height: 5.h),
                      TextFormField(
                        maxLines: 3,
                        keyboardType: TextInputType.text,
                        controller: paymentController.noteController,
                        decoration: const InputDecoration(
                          hintText: "Type note...",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => CustomElevatedButton(
                        buttonName: "Pay Now",
                        onPressed: paymentController.isValidAmount.value
                            ? () {
                                paymentController.makePayment();
                              }
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
                visible: paymentController.isLoading.value,
                child: const CustomLoading()),
          )
        ],
      ),
    );
  }
}
