import 'package:flutter/material.dart';

class RibbonMenu extends StatefulWidget {
  const RibbonMenu({super.key});

  @override
  State<RibbonMenu> createState() => _RibbonMenuState();
}

class _RibbonMenuState extends State<RibbonMenu> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 92,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                tabs: const [
                  Tab(text: "Home"),
                  Tab(text: "Business"),
                  Tab(text: "School"),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Icon(Icons.home),
                  Icon(Icons.business),
                  Icon(Icons.school),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
