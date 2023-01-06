import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PledgeDetails extends StatelessWidget {
  final PledgeElement pledge;

  final PaymentController paymentController = Get.find();
  final PledgeController pledgeController = Get.find();

  PledgeDetails({super.key, required this.pledge});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Obx(() {
                        return AlertDialog(
                          title: const Text('Choose Date'),
                          content: pledgeController.isLoading.value
                              ? const SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : SizedBox(
                                  height: 80,
                                  child: TextFormField(
                                    controller: pledgeController.reminderDate,
                                    //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons
                                            .calendar_today), //icon of text field
                                        labelText:
                                            "Reminder Date" //label text of field
                                        ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        pledgeController.reminderDate.text =
                                            formattedDate; //set output date to TextField value.

                                      } else {}
                                    },
                                  ),
                                ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: const Text('SAVE'),
                              onPressed: () {
                                pledgeController.setReminder(pledge.id,
                                    pledgeController.reminderDate.text);
                              },
                            ),
                          ],
                        );
                      });
                    },
                  );
                },
                icon: const Icon(Icons.notification_add))
          ],
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
                ListView.builder(
                    shrinkWrap: true,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(pledge.purpose.title,
                                    //     style: GoogleFonts.poppins(
                                    //         textStyle: const TextStyle(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.black))),
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
                const Spacer(),
                pledge.status == 1
                    ? const SizedBox.shrink()
                    : SizedBox(
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
