// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:default_project/repositories/settings_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:default_project/repositories/playlist_repository.dart';
import 'package:default_project/repositories/songs_repository.dart';
import 'package:default_project/repositories/user_repository.dart';

import 'blocs/export_blocs.dart';
import 'firebase_options.dart';
import 'model/user.dart';
import 'providers/firebase_provider.dart';
import 'providers/hive_provider.dart';
import 'services/my_logger.dart';
import 'view/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  MyLogger();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseProvider firebaseProvider = FirebaseProvider();
  HiveProvider hiveProvider = HiveProvider();

  SettingsRepository settingsRepository = SettingsRepository();

  SongsRepository songsRepository = SongsRepository(
    firebaseProvider: firebaseProvider,
    hiveProvider: hiveProvider,
  );
  await songsRepository.loadSongsFromFirebase();
  PlaylistRepository playlistRepository = PlaylistRepository(
    hiveProvider: hiveProvider,
    firebaseProvider: firebaseProvider,
  );
  UsersRepository usersRepository = UsersRepository(
    hiveProvider: hiveProvider,
    firebaseProvider: firebaseProvider,
  );

  runApp(EasyLocalization(
    startLocale: const Locale('cs'),
    supportedLocales: const [Locale('cs'), Locale('en')],
    path: 'assets/lang',
    fallbackLocale: const Locale('cs'),
    child: MyApp(
      songsRepository: songsRepository,
      playlistRepository: playlistRepository,
      usersRepository: usersRepository,
      settingsRepository: settingsRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final SongsRepository songsRepository;
  final PlaylistRepository playlistRepository;
  final UsersRepository usersRepository;
  final SettingsRepository settingsRepository;
  const MyApp({
    Key? key,
    required this.songsRepository,
    required this.playlistRepository,
    required this.usersRepository,
    required this.settingsRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomePageBloc(
              songsRepository: songsRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Songs viewer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          home: BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state.message.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.last)));
              }
            },
            child: HomePage(
              settingsRepository: settingsRepository,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> initHiveFunction() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
}
