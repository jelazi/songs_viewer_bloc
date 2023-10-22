import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../main.dart';
import '../pages/edit_pages/edit_lyrics.dart';
import '../pages/edit_pages/edit_page.dart';
import '../pages/home_page.dart';
import '../pages/presentation_page.dart';
import '../pages/preview_page.dart';
import '../pages/settings_page.dart';
import '../pages/sheet_view_page.dart';
import '../pages/youtube_video_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state.message.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.last)));
              }
            },
            child: HomePage(
              settingsRepository: settingsRepository,
            ),
          ),
        );
      case '/settingsPage':
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case '/editPage':
        return MaterialPageRoute(builder: (_) => const EditPage());
      case '/previewPage':
        return MaterialPageRoute(builder: (_) => const PreviewPage());
      case '/presentationPage':
        return MaterialPageRoute(builder: (_) => const PresentationPage());
      case '/sheetViewPage':
        return MaterialPageRoute(builder: (_) => const SheetViewPage());
      case '/youtubeVideoPage':
        return MaterialPageRoute(builder: (_) => const YoutubeVideoPage());
      case '/editLyricPage':
        return MaterialPageRoute(builder: (_) => EditLyricPage(isOriginalLyrics: false));
      case '/editOriginalLyricPage':
        return MaterialPageRoute(builder: (_) => EditLyricPage(isOriginalLyrics: true));
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
