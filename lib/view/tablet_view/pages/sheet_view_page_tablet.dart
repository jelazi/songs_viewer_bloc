import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SheetViewPageTablet extends StatelessWidget {
  const SheetViewPageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('sheetView'.tr()),
        ),
        body: const Center(child: Text('SheetViewPage')));
  }
}
