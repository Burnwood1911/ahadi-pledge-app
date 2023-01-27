import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/models/payment_methods.dart';
import 'package:ahadi_pledge/repos/payment_repo.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class PaymentController extends GetxController {
  final paymentRepositry = getIt.get<PaymentRepository>();
  RxBool isLoading = false.obs;
  RxList<PaymentElement> payments = RxList();
  RxList<PaymentMethod> paymentMethods = RxList();
  TextEditingController paymentAmount = TextEditingController();
  TextEditingController paymentReceipt = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    await getPayments();
  }

  Future<void> getPayments() async {
    isLoading(true);
    final result = await paymentRepositry.getPayments();
    var paymentsToSort = result.payments;
    paymentsToSort.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    payments.value = paymentsToSort;
    isLoading(false);
  }

  Future<void> getPaymentMethods() async {
    isLoading(true);
    final result = await paymentRepositry.getPaymentMethods();

    result.when((methods) async {
      paymentMethods.value = methods;
    }, (error) {
      showAppSnackbar(
          LocaleKeys.error_text.tr(), "Failed to get payment methods.");
    });

    isLoading(false);
  }

  Future<void> submitPayment(
      String amount, int typeId, int pledgeId, String receipt) async {
    isLoading(true);
    final result =
        await paymentRepositry.submitPayment(amount, typeId, pledgeId, receipt);
    paymentAmount.text = "";
    paymentReceipt.text = "";

    result.when((success) async {
      await getPayments();
      isLoading(false);
      Get.back();
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.payment_complete_text.tr());
    }, (error) {
      isLoading(false);
      Get.back();
      showAppSnackbar(LocaleKeys.error_text.tr(), error.message);
    });
  }

  int totalPaymentAmount() {
    if (payments.isNotEmpty) {
      var pap = payments.where((p0) => p0.verified == true);

      if (pap.isEmpty) {
        return 0;
      }

      return pap
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
