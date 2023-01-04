import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PledgeDetails extends StatelessWidget {
  final PledgeElement pledge;

  final PaymentController paymentController = Get.find();

  PledgeDetails({super.key, required this.pledge});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Details",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.black)),
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Total",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[500])),
                            ),
                            Row(
                              children: [
                                Text(
                                  pledge.amount,
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
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Remaining",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[500])),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${paymentController.payments.where((element) => element.pledgeId == pledge.id).isNotEmpty ? (int.parse(pledge.amount) - paymentController.payments.where((element) => element.pledgeId == pledge.id).map((e) => int.parse(e.amount)).reduce((value, element) => value + element)) : pledge.amount}",
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Achievement",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 0),
                    child: Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: int.parse(pledge.amount),
                          currentStep: paymentController.payments
                                  .where((element) =>
                                      element.pledgeId == pledge.id)
                                  .isNotEmpty
                              ? paymentController.payments
                                  .where((element) =>
                                      element.pledgeId == pledge.id)
                                  .map((e) => int.parse(e.amount))
                                  .reduce((value, element) => value + element)
                              : 0,
                          size: 16,
                          padding: 0,
                          selectedColor: Colors.green,
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
                Text("Payment History",
                    style: GoogleFonts.poppins(
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: Get.height * 0.35,
                  child: ListView.builder(
                      itemCount: paymentController.payments
                          .where((p) => p.pledgeId == pledge.id)
                          .length,
                      itemBuilder: ((context, index) {
                        final payment = paymentController.payments
                            .where((p) => p.pledgeId == pledge.id)
                            .toList()[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    size: 38,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(pledge.purpose.title,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black))),
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
                              Text(payment.amount.toString(),
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)))
                            ],
                          ),
                        );
                      })),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: (() {
                        Get.to(() => PaymentScreen(pledge));
                      }),
                      child: const Text("Pay")),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
