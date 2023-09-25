import 'package:default_project/repositories/settings_repository.dart';
import 'package:default_project/view/widgets/song_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../services/constants.dart';
import '../widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  final SettingsRepository settingsRepository;
  const HomePage({
    super.key,
    required this.settingsRepository,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _filter = TextEditingController();

  bool selectLargeScreen(Size size) {
    bool isLargeScreen = false;
    if (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux || size.width > 1023) {
      widget.settingsRepository.isLargeScreen = true;
      isLargeScreen = true;
      Size screenSize = PlatformDispatcher.instance.views.first.physicalSize;
      final height = screenSize.height;
      const estimatedHeight = 1640.0;
      fontSizeRatio = height / estimatedHeight;
    } else {
      widget.settingsRepository.isLargeScreen = false;
      isLargeScreen = false;
    }

    if (kIsWeb) {
      resizeFontsForWeb();
    } else {
      if (!widget.settingsRepository.isLargeScreen) {
        resizeFontsForMobile();
      } else {
        resizeFontsForDesktop();
      }
    }

    return isLargeScreen;
  }

  @override
  Widget build(BuildContext context) {
    selectLargeScreen(MediaQuery.of(context).size);
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const HomeDrawer(),
          body: CustomScrollView(slivers: [
            SliverLayoutBuilder(builder: ((context, constraints) {
              return SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,
                title: Align(alignment: Alignment.centerRight, child: Text('songsViewer'.tr())),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width - 20,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _filter,
                            decoration: InputDecoration(
                              hintText: 'filterSong'.tr(),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: (() {
                                  _filter.clear();
                                  context.read<HomePageBloc>().add(const FilterSong(filter: ''));
                                }),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (value) {
                              context.read<HomePageBloc>().add(FilterSong(filter: value));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            })),
            SliverList(
              delegate: SliverChildListDelegate(
                state.homePageProperties.listSong.map((song) => SongCard(song: song)).toList(),
              ),
            )
          ]),
        );
      },
    );
  }
}
