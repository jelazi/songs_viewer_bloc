import 'dart:io';

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
      if ((Platform.isAndroid || Platform.isIOS) && width < 600) {
        return mobileHomePage;
      } else if (Platform.isAndroid || Platform.isIOS) {
        return tabletHomePage;
      } else {
        return desktopHomePage;
      }
    });
  }
}
