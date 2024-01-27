import 'package:flutter/material.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Desktop Home Page'),
        ),
        body: const Center(
          child: Text('Desktop Home Page'),
        ));
  }
}
