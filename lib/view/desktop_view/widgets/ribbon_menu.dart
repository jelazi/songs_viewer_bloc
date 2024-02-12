import 'package:default_project/services/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../blocs/export_blocs.dart';
import 'ribbon_button.dart';

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
    return Container(
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
                Tab(text: "Edit"),
                Tab(text: "Settings"),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: TabBarView(
              controller: _tabController,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    BlocBuilder<PreviewChordBloc, PreviewChordState>(
                      builder: (context, state) {
                        return RibbonButton(
                            text: 'zoomIn'.tr(),
                            icon: Icon(Icons.zoom_in),
                            isEnabled: state.data.song != null,
                            onPressed: () {
                              context.read<PreviewChordBloc>().add(const ChangeFontSize(isIncrease: true));
                            });
                      },
                    ),
                    BlocBuilder<PreviewChordBloc, PreviewChordState>(
                      builder: (context, state) {
                        return RibbonButton(
                            text: 'zoomOut'.tr(),
                            isEnabled: state.data.song != null,
                            icon: Icon(Icons.zoom_out),
                            onPressed: () {
                              context.read<PreviewChordBloc>().add(const ChangeFontSize(isIncrease: false));
                            });
                      },
                    ),
                    BlocBuilder<PreviewChordBloc, PreviewChordState>(
                      builder: (context, state) {
                        return RibbonButton(
                            text: 'transpose'.tr(),
                            isEnabled: state.data.song != null,
                            icon: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.music_note,
                                  size: 18,
                                ),
                              ],
                            ),
                            onPressed: () {
                              context.read<PreviewChordBloc>().add(const TransposeChord(increment: 1));
                            });
                      },
                    ),
                    BlocBuilder<PreviewChordBloc, PreviewChordState>(
                      builder: (context, state) {
                        return RibbonButton(
                            text: 'transpose'.tr(),
                            isEnabled: state.data.song != null,
                            icon: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.music_note,
                                  size: 18,
                                ),
                              ],
                            ),
                            onPressed: () {
                              context.read<PreviewChordBloc>().add(const TransposeChord(increment: -1));
                            });
                      },
                    ),
                  ]),
                ),
                Icon(Icons.business),
                Icon(Icons.school),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
