import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/repos/payment_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final paymentRepositry = getIt.get<PaymentRepository>();
  RxBool isLoading = false.obs;
  RxList<PaymentElement> payments = RxList();
  TextEditingController paymentAmount = TextEditingController();
  TextEditingController paymentReceipt = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await getPayments();
  }

  Future<void> getPayments() async {
    isLoading(true);
    final result = await paymentRepositry.getPayments();
    payments.value = result.payments;
    isLoading(false);
  }

  Future<void> submitPayment(
      String amount, int typeId, int pledgeId, int userId) async {
    isLoading(true);
    final result =
        await paymentRepositry.submitPayment(amount, typeId, pledgeId, userId);
    if (result) {
      await getPayments();
      Get.back();
      Get.snackbar("Success", "Payment Complete");
    } else {
      Get.back();
      Get.snackbar("Failure", "Payment Failed");
    }
    isLoading(false);
  }

  int totalPaymentAmount() {
    if (payments.isNotEmpty) {
      return payments
          .map((element) => int.parse(element.amount))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  @override
  void dispose() {
    paymentAmount.dispose();
    paymentReceipt.dispose();
    super.dispose();
  }
}
