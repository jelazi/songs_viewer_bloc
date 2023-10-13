import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('presentation'.tr()),
        ),
        body: Center(child: Text('PresentationPage')));
  }
}
