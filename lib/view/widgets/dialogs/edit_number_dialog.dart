import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'edit_dialog.dart';

class EditNumberDialog extends StatefulWidget {
  String title;
  num value;
  int? maxValue;
  int? minValue;
  bool okBack = true;
  Function okClick;
  late TextEditingController textEditingController;
  EditNumberDialog({
    Key? key,
    required this.title,
    required this.value,
    required this.okClick,
    this.minValue,
    this.maxValue,
    this.okBack = true,
  }) : super(key: key) {
    textEditingController = TextEditingController(text: value.toString());
  }

  @override
  State<EditNumberDialog> createState() => _EditNumberDialogState();
}

class _EditNumberDialogState extends State<EditNumberDialog> {
  @override
  Widget build(BuildContext context) {
    return EditDialog(
        okBack: widget.okBack,
        title: widget.title,
        okClick: () {},
        widgetContent: TextField(
          keyboardType: (widget.value is double)
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number,
          inputFormatters: (widget.value is double)
              ? [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ]
              : [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
          controller: widget.textEditingController,
        ));
  }
}
