import 'package:flutter/material.dart';

class ResponsiveHomePage extends StatelessWidget {
  final Widget mobileHomePage;
  final Widget tabletHomePage;
  final Widget desktopHomePage;
  const ResponsiveHomePage({super.key, required this.mobileHomePage, required this.tabletHomePage, required this.desktopHomePage});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (width < 600) {
        return mobileHomePage;
      } else if (width < 1024) {
        return tabletHomePage;
      } else {
        return desktopHomePage;
      }
    });
  }
}
