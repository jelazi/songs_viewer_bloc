import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('edit'.tr()),
        ),
        body: Center(child: Text('EditPage')));
  }
}
