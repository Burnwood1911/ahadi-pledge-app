import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/repos/payment_repo.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final paymentRepositry = getIt.get<PaymentRepository>();
  RxBool isLoading = false.obs;
  RxList<PaymentElement> payments = RxList();

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

  int totalPaymentAmount() {
    if (payments.isNotEmpty) {
      return payments
          .map((element) => int.parse(element.amount!))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }
}
