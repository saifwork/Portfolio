import 'package:flutter/material.dart';

import 'app_router.dart';
import 'constants.dart';

class LayoutValues {
  final double extraBigFontSize;
  final double bigFontSize;
  final double mediumFontSize;
  final double smallFontSize;
  final double extraSmallFontSize;
  final double btnMargin;
  final double btnSize;
  final double spaced;
  final double padd;

  LayoutValues({
    required this.extraBigFontSize,
    required this.bigFontSize,
    required this.mediumFontSize,
    required this.smallFontSize,
    required this.extraSmallFontSize,
    required this.btnMargin,
    required this.btnSize,
    required this.spaced,
    required this.padd,
  });

  factory LayoutValues.fromBuildContext() {
    final isMobile =
        ResponsiveLayout.isMobile(AppRouter.navigatorKey.currentContext!);
    final extraBigFontSize = isMobile ? 40.0 : 50.0;
    final bigFontSize = isMobile ? 30.0 : 40.0;
    final mediumFontSize = isMobile ? 20.0 : 30.0;
    final smallFontSize = isMobile ? 15.0 : 20.0;
    final extraSmallFontSize = isMobile ? 10.0 : 15.0;
    final btnMargin = isMobile ? 10.0 : 15.0;
    final btnSize = isMobile ? 30.0 : 40.0;
    final spaced = isMobile ? space / 2 : space;
    final padd = isMobile ? padding / 2 : padding;

    return LayoutValues(
      extraBigFontSize: extraBigFontSize,
      bigFontSize: bigFontSize,
      mediumFontSize: mediumFontSize,
      smallFontSize: smallFontSize,
      extraSmallFontSize: extraSmallFontSize,
      btnMargin: btnMargin,
      btnSize: btnSize,
      spaced: spaced,
      padd: padd,
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget tabletScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.tabletScreenLayout,
    required this.webScreenLayout,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1100;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
// WEB SCREEN
          return webScreenLayout;
        } else if (constraints.maxWidth >= 600) {
// TABLET SCREEN
          return tabletScreenLayout;
        }
// MOBILE SCREEN
        return mobileScreenLayout;
      },
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  final Color bgColor;
  final double padding;

  const ResponsiveWidget({
    super.key,
    this.maxWidth = 600.0,
    required this.child,
    this.bgColor = Colors.transparent,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: bgColor,
        padding: EdgeInsets.all(padding),
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGridView({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;

    if (ResponsiveLayout.isWeb(context)) {
      crossAxisCount = 3; // For web
    } else if (ResponsiveLayout.isTablet(context)) {
      crossAxisCount = 2; // For tablet
    } else {
      crossAxisCount = 1; // For mobile
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        // mainAxisSpacing: 20.0,
        childAspectRatio: 1.1,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}