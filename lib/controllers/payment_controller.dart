import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/card_payment.dart' as card;
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/repos/payment_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final paymentRepositry = getIt.get<PaymentRepository>();
  RxBool isLoading = false.obs;
  RxList<PaymentElement> payments = RxList();
  RxList<card.Payment> cardPayments = RxList();
  TextEditingController paymentAmount = TextEditingController();
  TextEditingController paymentReceipt = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    await getPayments();
    await getCardPayments();
  }

  Future<void> getPayments() async {
    isLoading(true);
    final result = await paymentRepositry.getPayments();
    payments.value = result.payments;
    isLoading(false);
  }

  Future<void> getCardPayments() async {
    isLoading(true);
    final result = await paymentRepositry.getCardPayments();
    cardPayments.value = result.payments;
    isLoading(false);
  }

  Future<void> submitPayment(String amount, int typeId, int pledgeId) async {
    isLoading(true);
    final result =
        await paymentRepositry.submitPayment(amount, typeId, pledgeId);
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
      var pap = payments
          .map((element) => int.parse(element.amount))
          .reduce((value, element) => value + element);

      return pap;
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
