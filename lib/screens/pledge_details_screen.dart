import 'dart:developer';

import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/screens/payment_screen.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class PledgeDetails extends StatefulWidget {
  final PledgeElement pledge;

  PledgeDetails({super.key, required this.pledge});

  @override
  State<PledgeDetails> createState() => _PledgeDetailsState();
}

class _PledgeDetailsState extends State<PledgeDetails> {
  GlobalKey<FormState>? _formKey;
  PaymentController? paymentController;
  PledgeController? pledgeController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    paymentController = Get.find<PaymentController>();
    pledgeController = Get.find<PledgeController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            LocaleKeys.details_header_text.tr(),
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
                        return Form(
                          key: _formKey,
                          child: AlertDialog(
                            title: Text(LocaleKeys.reminder_date_text.tr()),
                            content: pledgeController!.isLoading.value
                                ? const SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : SizedBox(
                                    height: 80,
                                    child: TextFormField(
                                      controller:
                                          pledgeController!.reminderDate,
                                      //editing controller of this TextField
                                      decoration: InputDecoration(
                                          suffixIcon: const Icon(Icons
                                              .calendar_month), //icon of text field
                                          labelText: LocaleKeys.choose_date_text
                                              .tr() //label text of field
                                          ),
                                      readOnly: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LocaleKeys
                                              .empty_fields_error_text
                                              .tr();
                                        }
                                        return null;
                                      },
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

                                          pledgeController!.reminderDate.text =
                                              formattedDate; //set output date to TextField value.

                                        } else {}
                                      },
                                    ),
                                  ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(LocaleKeys.cancel_text.tr()),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: Text(LocaleKeys.save_text.tr()),
                                onPressed: () {
                                  if (_formKey!.currentState!.validate()) {
                                    pledgeController!.setReminder(
                                        widget.pledge.id,
                                        pledgeController!.reminderDate.text);
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                icon: const Icon(Icons.notification_add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => paymentController!.getPayments(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(() {
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
                                    LocaleKeys.total_text.tr(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.pledge.amount,
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
                                    LocaleKeys.remaining_text.tr(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${paymentController!.payments.where((element) => element.pledgeId == widget.pledge.id).isNotEmpty ? (int.parse(widget.pledge.amount) - (paymentController!.payments.where((element) => element.pledgeId == widget.pledge.id && element.verified == true).isEmpty ? 0 : paymentController!.payments.where((element) => element.pledgeId == widget.pledge.id && element.verified == true).map((e) => int.parse(e.amount)).reduce((value, element) => value + element))) : widget.pledge.amount}",
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
                        LocaleKeys.goal_progress_text.tr(),
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
                                totalSteps: int.parse(widget.pledge.amount),
                                currentStep: paymentController!.payments
                                        .where((element) =>
                                            element.pledgeId ==
                                            widget.pledge.id)
                                        .isNotEmpty
                                    ? paymentController!.payments
                                            .where((element) =>
                                                element.pledgeId ==
                                                    widget.pledge.id &&
                                                element.verified == true)
                                            .isEmpty
                                        ? 0
                                        : paymentController!.payments
                                            .where((element) =>
                                                element.pledgeId ==
                                                    widget.pledge.id &&
                                                element.verified == true)
                                            .map((e) => int.parse(e.amount))
                                            .reduce((value, element) =>
                                                value + element)
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
                      Text(LocaleKeys.payment_history_text.tr(),
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: paymentController!.payments
                              .where((p) => p.pledgeId == widget.pledge.id)
                              .length,
                          itemBuilder: ((context, index) {
                            final payment = paymentController!.payments
                                .where((p) => p.pledgeId == widget.pledge.id)
                                .toList()[index];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.35,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.payment,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 38,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: FittedBox(
                                        child: Container(
                                          width: 70,
                                          height: 20,
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              color: payment.verified
                                                  ? Colors.green[500]
                                                  : Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: FittedBox(
                                            child: Text(
                                              payment.verified
                                                  ? LocaleKeys.complete_text
                                                      .tr()
                                                  : LocaleKeys.pending_text
                                                      .tr(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.25,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: FittedBox(
                                        child: Text(payment.amount.toString(),
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                      const SizedBox(
                        height: 24,
                      ),
                      widget.pledge.status == 1
                          ? const SizedBox.shrink()
                          : SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor),
                                  onPressed: (() {
                                    Get.to(() => PaymentScreen(widget.pledge));
                                  }),
                                  child: Text(LocaleKeys.pay_text.tr())),
                            )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
