// ignore_for_file: prefer_const_constructors

import 'package:ahadi_pledge/api/pledge_form.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/models/pledge_purposes.dart';
import 'package:ahadi_pledge/models/pledge_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreatePledge extends StatefulWidget {
  const CreatePledge({super.key});

  @override
  State<CreatePledge> createState() => _CreatePledgeState();
}

class _CreatePledgeState extends State<CreatePledge> {
  final PledgeController pledgeController = Get.find();

  TextEditingController? amount;
  TextEditingController? description;
  TextEditingController? dateInput;

  int? selectedPledgeTypeId;
  int? selectedPledgePurposeId;

  @override
  void initState() {
    super.initState();
    selectedPledgeTypeId = pledgeController.pledgetypes[0].id;
    selectedPledgePurposeId = pledgeController.pledgepurposes[0].id;

    amount = TextEditingController();
    description = TextEditingController();
    dateInput = TextEditingController();

    dateInput?.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Pledge",
            style:
                GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black)),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Obx((() => pledgeController.isLoading.value
            ? Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: [Colors.blue],
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    pathBackgroundColor: Colors.white),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pledge Type",
                      style: GoogleFonts.poppins(),
                    ),
                    DropdownButton<String>(
                      value: pledgeController.pledgetypes
                          .firstWhere(
                              (element) => element.id == selectedPledgeTypeId)
                          .title,
                      isExpanded: true,
                      items: pledgeController.pledgetypes
                          .toList()
                          .map((TypePledge value) {
                        return DropdownMenuItem<String>(
                          value: value.title,
                          child: Text(value.title!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPledgeTypeId = pledgeController.pledgetypes
                              .firstWhere((item) => item.title == value)
                              .id;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Purpose",
                      style: GoogleFonts.poppins(),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: pledgeController.pledgepurposes
                          .firstWhere((element) =>
                              element.id == selectedPledgePurposeId)
                          .title,
                      items: pledgeController.pledgepurposes
                          .toList()
                          .map((PurposePledge value) {
                        return DropdownMenuItem<String>(
                          value: value.title,
                          child: Text(
                            value.title!,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPledgePurposeId = pledgeController
                              .pledgepurposes
                              .firstWhere((item) => item.title == value)
                              .id;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Deadline Date" //label text of field
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
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput?.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: (() {
                              final form = PledgeForm(
                                  amount: amount!.text,
                                  deadline: dateInput!.text,
                                  description: description!.text,
                                  purpose_id: selectedPledgePurposeId!,
                                  name: pledgeController.pledgepurposes
                                      .firstWhere((element) =>
                                          element.id == selectedPledgePurposeId)
                                      .title!,
                                  status: true,
                                  type_id: selectedPledgeTypeId!,
                                  user_id: 2);

                              pledgeController.createPledge(form);
                            }),
                            child: Text("Create")))
                  ],
                ),
              ))),
      ),
    );
  }

  @override
  void dispose() {
    amount?.dispose();
    description?.dispose();
    dateInput?.dispose();
    super.dispose();
  }
}
