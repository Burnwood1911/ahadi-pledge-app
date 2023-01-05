import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/screens/pledge_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Pledges extends GetView<PledgeController> {
  const Pledges({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Pledges",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.black)),
            ),
            centerTitle: true,
          ),
          body: Obx(() => controller.isLoading.value
              ? const Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotatePulse,
                      colors: [Colors.blue],
                      strokeWidth: 3,
                      backgroundColor: Colors.white,
                      pathBackgroundColor: Colors.white),
                )
              : ListView.separated(
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
                              // Container(
                              //   width: 70,
                              //   height: 20,
                              //   padding: EdgeInsets.all(1),
                              //   decoration: BoxDecoration(
                              //       color: Colors.green[500],
                              //       borderRadius: BorderRadius.circular(16)),
                              //   child: FittedBox(
                              //     child: Text(
                              //       "COMPLETE",
                              //       style: GoogleFonts.poppins(
                              //           textStyle: TextStyle(
                              //               fontSize: 12,
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.w300)),
                              //     ),
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))),
    );
  }
}
