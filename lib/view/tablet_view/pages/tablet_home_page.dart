import 'package:flutter/material.dart';

class TabletHomePage extends StatelessWidget {
  const TabletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tablet Home Page'),
        ),
        body: const Center(
          child: Text('Tablet Home Page'),
        ));
  }
}
