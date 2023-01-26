import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/screens/pledge_details_screen.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:easy_localization/easy_localization.dart';

class Pledges extends GetView<PledgeController> {
  const Pledges({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              LocaleKeys.pledges_header_text.tr(),
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.black)),
            ),
            centerTitle: true,
          ),
          body: Obx(() => controller.isLoading.value
              ? Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotatePulse,
                      colors: [Theme.of(context).primaryColor],
                      strokeWidth: 3,
                      backgroundColor: Colors.white,
                      pathBackgroundColor: Colors.white),
                )
              : controller.pledges.isEmpty
                  ? const Center(
                      child: Text("No Items."),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await Get.find<PaymentController>().getPayments();
                        await controller.getPledges();
                      },
                      child: ListView.separated(
                        itemCount: controller.pledges.length,
                        padding: const EdgeInsets.all(16),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: PledgeDetails(
                              pledge: controller.pledges[index],
                            ),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.pledges[index].purpose.title,
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Text(
                                      controller.pledges[index].deadline
                                          .toLocal()
                                          .toString()
                                          .split(" ")[0],
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${controller.pledges[index].amount}Tsh",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20,
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          color: getPledgeVerifiedPaymentsTotal(
                                                      index) >=
                                                  int.parse(controller
                                                      .pledges[index].amount)
                                              ? Colors.green[500]
                                              : Colors.red[500],
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: FittedBox(
                                        child: Text(
                                          getPledgeVerifiedPaymentsTotal(
                                                      index) >=
                                                  int.parse(controller
                                                      .pledges[index].amount)
                                              ? "PAID"
                                              : "UNPAID",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
    );
  }

  int getPledgeVerifiedPaymentsTotal(int index) {
    PaymentController paymentController = Get.find<PaymentController>();
    int pledgeId = controller.pledges[index].id;

    var payments = paymentController.payments
        .where((payment) => payment.pledgeId == pledgeId);
    if (payments.isEmpty) {
      return 0;
    } else {
      var verifiedPayments =
          payments.where((payment) => payment.verified == true);

      if (verifiedPayments.isEmpty) {
        return 0;
      } else {
        return verifiedPayments
            .map((e) => int.parse(e.amount))
            .reduce((current, acc) => current + acc);
      }
    }
  }
}
