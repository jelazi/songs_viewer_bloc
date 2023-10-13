import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SheetViewPage extends StatelessWidget {
  const SheetViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('sheetView'.tr()),
        ),
        body: Center(child: Text('SheetViewPage')));
  }
}
