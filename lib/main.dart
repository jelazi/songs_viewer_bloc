// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:default_project/repositories/settings_repository.dart';
import 'package:default_project/services/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

part 'main.part.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  MyLogger();
  await initHiveFunction();
  await initProvidersRepositories();

  runApp(EasyLocalization(
    startLocale: const Locale('cs'),
    supportedLocales: const [Locale('cs'), Locale('en')],
    path: 'assets/lang',
    fallbackLocale: const Locale('cs'),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
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
          BlocProvider(
              create: (context) => PreviewChordBloc(
                    settingsRepository: settingsRepository,
                  )),
        ],
        child: MaterialApp(
          title: 'Songs viewer',
          theme: ThemeData(
            primarySwatch: getMaterialColor(AppColor.primaryColor),
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
  //Hive.initFlutter(directory.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TypeUserAdapter());
}
