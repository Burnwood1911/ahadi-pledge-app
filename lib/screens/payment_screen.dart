import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentScreen extends StatefulWidget {
  final PledgeElement pledge;

  const PaymentScreen(this.pledge, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentController? controller;
  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PaymentController>();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.pay_text.tr(),
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        return controller!.isLoading.value
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
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 18.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller!.paymentAmount,
                          decoration: InputDecoration(
                              labelText: LocaleKeys.amount_text.tr(),
                              filled: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.empty_fields_error_text.tr();
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 18.0),
                      child: TextFormField(
                          maxLines: 10,
                          controller: controller!.paymentReceipt,
                          decoration: InputDecoration(
                              labelText: LocaleKeys.receipt_text.tr(),
                              filled: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.empty_fields_error_text.tr();
                            }
                            return null;
                          }),
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
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: (() {
                              if (_formKey!.currentState!.validate()) {
                                controller!.submitPayment(
                                  controller!.paymentAmount.text,
                                  widget.pledge.type.id,
                                  widget.pledge.id,
                                  controller!.paymentReceipt.text,
                                );
                              }
                            }),
                            child: Text(LocaleKeys.submit_text.tr())),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
