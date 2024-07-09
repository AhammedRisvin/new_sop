import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../utils/app_images.dart';
import '../view model/main_bottom_navigation_provider.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({
    super.key,
  });

  @override
  MainBottomNavState createState() => MainBottomNavState();
}

class MainBottomNavState extends State<MainBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  List<String> assetImage = [
    AppImages.homeUntapped,
    AppImages.searchIconBn,
    AppImages.pharmaUntapped,
    AppImages.pharmaUntapped,
    AppImages.settingsUntapped,
  ];

  List<String> selectedIcon = [
    AppImages.homeUntapped,
    AppImages.searchIconBn,
    AppImages.pharmaUntapped,
    AppImages.pharmaUntapped,
    AppImages.settingsUntapped,
  ];

  List<String> title = ["Home", "Search", "Loyalty", "Grocery", "Settings"];

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkMode, child) =>
          Consumer<MainBottomNavigationProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: isDarkMode ? AppConstants.black : AppConstants.white,
          body: provider.tabs[provider.bottomNavIndex],
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              children: isDarkMode
                  ? [
                      Image.asset(
                        AppImages.loyaltyGold,
                      ),
                    ]
                  : [
                      Image.asset(
                        AppImages.loyaltyUntapped,
                      ),
                    ],
            ),
            onPressed: () {
              provider.updateBottomNavIndex(2);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: title.length,
            tabBuilder: (int index, bool isActive) {
              if (index == 2) {
                var thirdTitle = title[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          thirdTitle,
                          style: TextStyle(
                            color: isDarkMode
                                ? const Color(0xFF333333)
                                : const Color(0xFFC1AE97),
                            fontSize: 14,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                var titles = title[index];
                var imageIcon = provider.bottomNavIndex == index
                    ? selectedIcon[index]
                    : assetImage[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageIcon,
                      width: 24,
                      height: 24,
                      color: isDarkMode
                          ? const Color(0xFF333333)
                          : const Color(0xFFC1AE97),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FittedBox(
                        child: Text(
                          titles,
                          style: TextStyle(
                            color: isDarkMode
                                ? const Color(0xFF333333)
                                : const Color(0xFFC1AE97),
                            fontSize: 12,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
            height: 70,
            backgroundGradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: isDarkMode
                  ? [
                      const Color(0xFFF3E1C9),
                      const Color(0xFFEEDBC3),
                      const Color(0xFFDECBB1),
                      const Color(0xFFC5B195),
                      const Color(0xFFB49F81)
                    ]
                  : [
                      const Color(0xFF10274A),
                      const Color(0xFF122B50),
                      const Color(0xFF193662),
                      const Color(0xFF1C3B6A)
                    ],
            ),
            activeIndex: provider.bottomNavIndex,
            splashColor: Colors.transparent,
            notchAndCornersAnimation: borderRadiusAnimation,
            splashSpeedInMilliseconds: 500,
            splashRadius: 0,
            notchSmoothness: NotchSmoothness.softEdge,
            gapLocation: GapLocation.none,
            leftCornerRadius: 28,
            rightCornerRadius: 28,
            onTap: (index) {
              provider.updateBottomNavIndex(index);
            },
            hideAnimationController: _hideBottomBarAnimationController,
            shadow: const BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 0,
              spreadRadius: 0,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen(this.iconData, {super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: [
          const SizedBox(height: 64),
          Center(
            child: CircularRevealAnimation(
              animation: animation,
              centerOffset: const Offset(80, 80),
              maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
              child: Icon(
                widget.iconData,
                color: Colors.indigoAccent,
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
