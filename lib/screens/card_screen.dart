import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  UserController? userController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                "Card",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(color: Colors.black)),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      userController!.requestCard();
                    },
                    icon: const Icon(Icons.add))
              ],
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    text: "Cards",
                  ),
                  Tab(
                    text: "Payments",
                  )
                ],
              ),
            ),
            body: TabBarView(
                controller: _tabController,
                children: [LeftSide(), RightSide()])));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

class LeftSide extends StatelessWidget {
  LeftSide({super.key});

  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Theme.of(context).primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          )
        : Container());
  }
}

class RightSide extends GetView<PaymentController> {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Theme.of(context).primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          )
        : controller.cardPayments.isEmpty
            ? const Center(
                child: Text("No items."),
              )
            : ListView.separated(
                itemCount: controller.cardPayments.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      controller.cardPayments[index].amount.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
              ));
  }
}
