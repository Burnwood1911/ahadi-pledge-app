import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/screens/card_screen.dart';
import 'package:ahadi_pledge/screens/create_pledge_screen.dart';
import 'package:ahadi_pledge/screens/mainscreen.dart';
import 'package:ahadi_pledge/screens/pledges_screen.dart';
import 'package:ahadi_pledge/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;

  PledgeController? pledgeController;
  PaymentController? paymentController;

  @override
  void initState() {
    super.initState();
    Get.delete<AuthController>();
    _controller = PersistentTabController(initialIndex: 0);
    pledgeController = Get.find<PledgeController>();
    paymentController = Get.find<PaymentController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style16, // Choose the nav bar style with this property.
    ));
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      const Pledges(),
      const CreatePledge(),
      const CardScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.list_alt),
        title: ("Pledges"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (p0) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const CreatePledge(),
            pageTransitionAnimation: PageTransitionAnimation.slideUp,
          );
        },
        icon: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.card_membership),
        title: ("Cards"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
