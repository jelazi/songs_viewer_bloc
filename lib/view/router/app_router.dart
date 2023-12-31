import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../repositories/settings_repository.dart';
import '../pages/edit_pages/edit_chords.dart';
import '../pages/edit_pages/edit_lyrics.dart';
import '../pages/edit_pages/edit_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/presentation_page.dart';
import '../pages/preview_page.dart';
import '../pages/settings_page.dart';
import '../pages/sheet_view_page.dart';
import '../pages/youtube_video_page.dart';

class AppRouter {
  SettingsRepository settingsRepository;
  AppRouter({
    required this.settingsRepository,
  });
  Route onGenerateRoute(
    RouteSettings routeSettings,
  ) {
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
        return MaterialPageRoute(builder: (_) => const EditLyricPage(isOriginalLyrics: false));
      case '/editOriginalLyricPage':
        return MaterialPageRoute(builder: (_) => const EditLyricPage(isOriginalLyrics: true));
      case '/editChordsPage':
        return MaterialPageRoute(builder: (_) => const EditChordsPage(isOriginalLyrics: false));
      case '/editOriginalChordsPage':
        return MaterialPageRoute(builder: (_) => const EditChordsPage(isOriginalLyrics: true));
      case '/loginPage':
        if (settingsRepository.currentUser.name == '') {
          return MaterialPageRoute(builder: (_) => LoginPage());
        } else {
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
        }
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
