import 'package:default_project/repositories/settings_repository.dart';
import 'package:default_project/view/widgets/song_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../services/constants.dart';

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
            appBar: AppBar(
              title: const Text('New page'),
            ),
            body: ListView(
              children: state.homePageProperties.listSong.map((song) => SongCard(song: song)).toList(),
            ));
      },
    );
  }
}
