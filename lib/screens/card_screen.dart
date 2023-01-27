import 'package:ahadi_pledge/controllers/card_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/common.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
    cardController.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                "Card",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(color: Colors.black)),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      userController.requestCard();
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: const LeftSide()));
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => cardController.isLoading.value
        ? Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Theme.of(context).primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cardController.cards.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  cardController.selectedCardId.value =
                      cardController.cards[index].card.id;

                  cardController.getCardPayments();

                  Get.to(() => const CardPaymentsScreen());
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cardController.cards[index].card.cardNo}/${cardController.cards[index].userId}",
                        style: GoogleFonts.poppins(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: 70,
                        height: 20,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: cardController.cards[index].card.status == 1
                                ? Colors.green[500]
                                : Colors.red,
                            borderRadius: BorderRadius.circular(16)),
                        child: FittedBox(
                          child: Text(
                            cardController.cards[index].card.status == 1
                                ? "Active"
                                : "Inactive",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ));
  }
}

class CardPaymentsScreen extends StatelessWidget {
  const CardPaymentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Card Payments",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      body: Obx(() => cardController.isLoading.value
          ? Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  colors: [Theme.of(context).primaryColor],
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  pathBackgroundColor: Colors.white),
            )
          : cardController.payments.isEmpty
              ? Center(
                  child: Text(LocaleKeys.no_items_text.tr()),
                )
              : ListView.separated(
                  itemCount: cardController.payments.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${currencyFormatter.format(cardController.payments[index].amount)} TSH",
                          style: GoogleFonts.poppins(),
                        ),
                        Text(cardController.payments[index].formattedDate)
                      ],
                    ),
                  ),
                )),
    );
  }
}
