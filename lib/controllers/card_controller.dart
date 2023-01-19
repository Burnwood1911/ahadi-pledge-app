import 'package:ahadi_pledge/models/card.dart';
import 'package:ahadi_pledge/models/card_payment.dart';
import 'package:ahadi_pledge/repos/card_repo.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:get/get.dart';
import '../di/service_locater.dart';

class CardController extends GetxController {
  static CardController instance = Get.find<CardController>();
  final cardRepository = getIt.get<CardRepository>();

  RxList<CardElement> cards = RxList();

  RxList<Payment> payments = RxList();

  RxBool isLoading = RxBool(false);

  RxInt selectedCardId = RxInt(0);

  Future<void> getCards() async {
    isLoading(true);
    final result = await cardRepository.getCards();
    result.when((card) {
      cards.value = card.cards;
    }, (error) => showAppSnackbar("Error", "Failed to load Cards"));
    isLoading(false);
  }

  Future<void> getCardPayments() async {
    isLoading(true);
    final result = await cardRepository.getCardPayments(selectedCardId.value);
    result.when((payment) {
      payments.value = payment.payments;
    }, (error) => showAppSnackbar("Error", "Failed to load Cards"));
    isLoading(false);
  }
}

final CardController cardController = CardController.instance;
