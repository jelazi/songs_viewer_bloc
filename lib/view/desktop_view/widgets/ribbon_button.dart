import 'package:flutter/material.dart';

import '../../../services/constants.dart';

class RibbonButton extends StatefulWidget {
  const RibbonButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isEnabled,
  });

  final String text;
  final Widget icon;
  final Function onPressed;
  final bool isEnabled;

  @override
  State<RibbonButton> createState() => _RibbonButtonState();
}

class _RibbonButtonState extends State<RibbonButton> {
  bool _isHovering = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (event) {
        if (!widget.isEnabled) {
          return;
        }
        setState(() => _isHovering = true);
      },
      onExit: (event) {
        if (!widget.isEnabled) {
          return;
        }
        setState(() {
          _isHovering = false;
          _isPressed = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          if (!widget.isEnabled) {
            return;
          }
          widget.onPressed();
        },
        onTapDown: (event) {
          if (!widget.isEnabled) {
            return;
          }
          setState(() => _isPressed = true);
        },
        onTapUp: (event) {
          if (!widget.isEnabled) {
            return;
          }
          setState(() => _isPressed = false);
        },
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: _isPressed && _isHovering
                    ? AppColor.alertWarningColor
                    : _isHovering
                        ? AppColor.primaryColor
                        : AppColor.grey3Color,
                width: _isHovering ? 2 : 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              Container(
                  alignment: Alignment.center,
                  width: 70,
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.isEnabled ? AppColor.grey1Color : AppColor.grey3Color,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
