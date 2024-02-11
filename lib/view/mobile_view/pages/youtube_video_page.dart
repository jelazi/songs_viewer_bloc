import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class YoutubeVideoPageMobile extends StatelessWidget {
  const YoutubeVideoPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('youtubeVideo'.tr()),
        ),
        body: const Center(child: Text('YoutubeVideoPage')));
  }
}
