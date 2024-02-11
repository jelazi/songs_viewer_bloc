import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PresentationPageTablet extends StatelessWidget {
  const PresentationPageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('presentation'.tr()),
        ),
        body: const Center(child: Text('PresentationPage')));
  }
}
