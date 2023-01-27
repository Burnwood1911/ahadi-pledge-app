import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../utils/common.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PledgeController? pledgeController;
  PaymentController? paymentController;

  @override
  void initState() {
    super.initState();
    pledgeController = Get.find<PledgeController>();
    paymentController = Get.find<PaymentController>();
    userController.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => pledgeController!.isLoading.value
          ? Center(
              child: SizedBox(
                height: 200,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: [Theme.of(context).primaryColor],
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    pathBackgroundColor: Colors.white),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${LocaleKeys.hello_text.tr()} ${userController.user.value?.fname}",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/flex-logo.png",
                          height: 30,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/salary.png",
                                height: 130,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                LocaleKeys.total_text.tr(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor)),
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      currencyFormatter.format(pledgeController!
                                          .totalPledgeAmount()),
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      "Tsh",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/coin.png",
                                height: 130,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                LocaleKeys.remaining_text.tr(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor)),
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      currencyFormatter.format(pledgeController!
                                              .totalPledgeAmount() -
                                          paymentController!
                                              .totalPaymentAmount()),
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      "Tsh",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  LocaleKeys.goal_progress_text.tr(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 0),
                    child: Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: pledgeController!.pledges.isNotEmpty
                              ? pledgeController!.totalPledgeAmount()
                              : 100,
                          currentStep: paymentController!.payments.isNotEmpty
                              ? paymentController!.totalPaymentAmount()
                              : 0,
                          size: 16,
                          padding: 0,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Colors.black,
                          roundedEdges: const Radius.circular(10),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  LocaleKeys.history_text.tr(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 8,
                ),
                paymentController!.payments.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Center(
                          child: Text(LocaleKeys.no_items_text.tr()),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: ((context, index) {
                          final payment =
                              paymentController!.payments.toList()[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      size: 38,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              pledgeController!.pledges
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      payment.pledgeId)
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                        ),
                                        Text(
                                          payment.createdAt
                                              .toLocal()
                                              .toString()
                                              .split(" ")[0],
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                    currencyFormatter
                                        .format(int.parse(payment.amount)),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)))
                              ],
                            ),
                          );
                        }))
              ],
            )),
    );
  }
}
