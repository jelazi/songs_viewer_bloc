import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../services/constants.dart';
import 'my_progress_indicator.dart';

enum TypeNotification {
  warning,
  error,
}

class MyToast {
  static showText({
    required String text,
    required TypeNotification typeNotification,
    String typeNotificationString = 'Warning',
    String? errorCode,
    double? usableTime,
  }) {
    switch (typeNotification) {
      case TypeNotification.warning:
        typeNotificationString = '${'warning'.tr()}: ';
        break;
      case TypeNotification.error:
        typeNotificationString = 'error'.tr();
        break;
    }
    late CancelFunc cancel;
    cancel = BotToast.showCustomText(
      backButtonBehavior: BackButtonBehavior.close,
      duration: const Duration(seconds: 10),
      toastBuilder: (_) {
        return Container(
          margin: const EdgeInsets.all(15),
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 250,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: typeNotificationString,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: typeNotification == TypeNotification.error ? Colors.red : AppColor.primaryColor)),
                                  TextSpan(
                                    text: text,
                                    style: const TextStyle(color: AppColor.grey1Color),
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            cancel();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4)),
                            child: const Icon(
                              Icons.close,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(errorCode ?? '',
                        style: TextStyle(
                          color: typeNotification == TypeNotification.error ? Colors.red : AppColor.primaryColor,
                          fontSize: 12.0,
                        ))
                  ],
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                      width: 350,
                      child: MyProgressIndicator(
                        usableTime: usableTime,
                        color: typeNotification == TypeNotification.error ? Colors.red : AppColor.primaryColor,
                        backgroundColor: typeNotification == TypeNotification.error ? const Color.fromARGB(255, 245, 187, 181) : AppColor.primaryLightestColor,
                      ))),
            ],
          ),
        );
      },
    );
    return cancel;
  }
}
