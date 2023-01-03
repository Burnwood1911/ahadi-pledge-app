import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final PledgeController pledgeController = Get.find();
  final PaymentController paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => pledgeController.isLoading.value
          ? const Center(
              child: SizedBox(
                height: 200,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: [Colors.blue],
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
                      "Hello Alex!",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.notifications))
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
                                    "${pledgeController.totalPledgeAmount()}",
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
                                height: 130,
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
                                    "${pledgeController.totalPledgeAmount() - paymentController.totalPaymentAmount()}",
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
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Goal Progress",
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
                          totalSteps: pledgeController.totalPledgeAmount(),
                          currentStep: paymentController.totalPaymentAmount(),
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
                Text(
                  "History",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: List.generate(
                      3,
                      (index) => Container(
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
                                        Text("Ujenzi",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black))),
                                        Text(
                                          "12th Dec 2022",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text("500,000Tsh",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)))
                              ],
                            ),
                          )),
                )
              ],
            )),
    );
  }
}
