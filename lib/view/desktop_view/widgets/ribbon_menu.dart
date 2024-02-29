import 'package:default_project/services/constants.dart';
import 'package:default_project/view/mobile_view/widgets/dialogs/dialogs_export.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../blocs/export_blocs.dart';
import '../../../model/song/song.dart';
import 'my_toast.dart';
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
    return BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
      builder: (context, state) {
        return Container(
          height: 92,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: state.bodyName == 'preview'
                          ? TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              controller: _tabController,
                              tabs: [
                                Tab(text: 'home'.tr()),
                                Tab(text: 'preview'.tr()),
                                Tab(text: 'settings'.tr()),
                              ],
                            )
                          : TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              controller: _tabController,
                              tabs: [
                                Tab(text: 'home'.tr()),
                                Tab(text: 'edit'.tr()),
                                Tab(text: 'settings'.tr()),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 60,
                      child: state.bodyName == 'preview'
                          ? TabBarView(
                              controller: _tabController,
                              children: const [
                                HomeTabbar(),
                                PreviewTabbar(),
                                SettingsTabbar(),
                              ],
                            )
                          : TabBarView(
                              controller: _tabController,
                              children: const [
                                HomeTabbar(),
                                EditTabbar(),
                                SettingsTabbar(),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.isSelectedSong,
                    child: GestureDetector(
                      onTap: () {
                        context.read<DesktopRibbonMenuBloc>().add(const ChangeHomeBody(bodyName: 'preview'));
                      },
                      child: BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
                        builder: (context, state) {
                          return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: state.bodyName == 'preview' ? AppColor.primaryLightestColor : null,
                                border: const Border(
                                    left: BorderSide(
                                      color: AppColor.grey3Color,
                                    ),
                                    bottom: BorderSide(
                                      color: AppColor.grey3Color,
                                    )),
                              ),
                              child: Text('preview'.tr()));
                        },
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.isSelectedSong,
                    child: GestureDetector(
                      onTap: () {
                        context.read<DesktopRibbonMenuBloc>().add(const ChangeHomeBody(bodyName: 'edit'));
                      },
                      child: BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
                        builder: (context, state) {
                          return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: state.bodyName == 'edit' ? AppColor.primaryLightestColor : null,
                                border: const Border(
                                    left: BorderSide(
                                      color: AppColor.grey3Color,
                                    ),
                                    bottom: BorderSide(
                                      color: AppColor.grey3Color,
                                    )),
                              ),
                              child: Text('edit'.tr()));
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class EditTabbar extends StatelessWidget {
  const EditTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
      builder: (context, state) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [],
            ));
      },
    );
  }
}

class SettingsTabbar extends StatelessWidget {
  const SettingsTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Row(
          children: [
            Icon(Icons.settings),
          ],
        ));
  }
}

class PreviewTabbar extends StatelessWidget {
  const PreviewTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        BlocBuilder<PreviewChordBloc, PreviewChordState>(
          builder: (context, state) {
            return RibbonButton(
                text: 'zoomIn'.tr(),
                icon: const Icon(Icons.zoom_in),
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
                icon: const Icon(Icons.zoom_out),
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
    );
  }
}

class HomeTabbar extends StatelessWidget {
  const HomeTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
          builder: (context, state) {
            return state.isSelectedSong
                ? state.bodyName == 'preview'
                    ? Row(
                        children: [
                          BlocBuilder<PreviewChordBloc, PreviewChordState>(
                            builder: (context, state) {
                              return RibbonButton(
                                  text: 'zoomIn'.tr(),
                                  icon: const Icon(Icons.zoom_in),
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
                                  icon: const Icon(Icons.zoom_out),
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
                        ],
                      )
                    : Row(
                        children: [
                          getNewSongButton(context),
                          RibbonButton(
                              text: 'lyrics'.tr(),
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                context.read<DesktopRibbonMenuBloc>().add(const ChangeEditBody(bodyName: 'lyrics'));
                              },
                              isEnabled: true,
                              isSelected: state.bodyEditName == 'lyrics'),
                          RibbonButton(
                              text: 'chord'.tr(),
                              icon: const Icon(Icons.piano),
                              onPressed: () {
                                context.read<DesktopRibbonMenuBloc>().add(const ChangeEditBody(bodyName: 'chords'));
                              },
                              isEnabled: true,
                              isSelected: state.bodyEditName == 'chords'),
                          RibbonButton(
                              text: 'note'.tr(),
                              icon: const Icon(Icons.music_note),
                              onPressed: () {
                                context.read<DesktopRibbonMenuBloc>().add(const ChangeEditBody(bodyName: 'note'));
                              },
                              isEnabled: true,
                              isSelected: state.bodyEditName == 'note'),
                          RibbonButton(
                              text: 'otherSettings'.tr(),
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                context.read<DesktopRibbonMenuBloc>().add(const ChangeEditBody(bodyName: 'settings'));
                              },
                              isEnabled: true,
                              isSelected: state.bodyEditName == 'settings'),
                        ],
                      )
                : Row(
                    children: [
                      getNewSongButton(context),
                      // Container(padding: const EdgeInsets.only(left: 10), child: Text('selectSong'.tr(), style: h4TextStyle)),
                    ],
                  );
          },
        ));
  }

  RibbonButton getNewSongButton(BuildContext context) {
    return RibbonButton(
      text: 'newSong'.tr(),
      icon: const Icon(Icons.new_label),
      onPressed: () {
        TextEditingController _nameController = TextEditingController();
        TextEditingController _artistController = TextEditingController();
        showDialog(
            context: context,
            builder: (context) {
              return EditDialog(
                  width: 300,
                  height: 300,
                  title: 'newSong'.tr(),
                  okBack: false,
                  okClick: () {
                    if (_nameController.text.isEmpty) {
                      MyToast.showText(text: 'nameSongIsEmpty'.tr(), typeNotification: TypeNotification.error);
                      return;
                    }
                    Song song = Song.empty()
                      ..title = _nameController.text
                      ..interpret = _artistController.text;
                    context.read<EditSongBloc>().add(CreateNewSong(song: song));
                    Navigator.pop(context);
                    context.read<DesktopRibbonMenuBloc>().add(ChangeIsSelectedSong(song: song));
                    context.read<DesktopRibbonMenuBloc>().add(const ChangeHomeBody(bodyName: 'edit'));
                  },
                  widgetContent: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'songName'.tr(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _artistController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'artist'.tr(),
                        ),
                      ),
                    ],
                  ));
            });
      },
      isEnabled: true,
    );
  }
}
