import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PaymentScreen extends GetView<PaymentController> {
  final PledgeElement pledge;

  const PaymentScreen(this.pledge, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Pay",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        return controller.isLoading.value
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
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.paymentAmount,
                      decoration: const InputDecoration(
                          labelText: "Amount", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      maxLines: 10,
                      controller: controller.paymentReceipt,
                      decoration: const InputDecoration(
                          labelText: "Receipt", filled: true),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          onPressed: (() {
                            if (controller.paymentAmount.text.isNotEmpty &&
                                controller.paymentReceipt.text.isNotEmpty) {
                              controller.submitPayment(
                                controller.paymentAmount.text,
                                pledge.type.id,
                                pledge.id,
                                controller.paymentReceipt.text,
                              );
                            } else {
                              Get.snackbar(
                                  "Error", "All field must not be empty");
                            }
                          }),
                          child: const Text("Submit")),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
