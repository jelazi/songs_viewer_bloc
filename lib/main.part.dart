part of 'main.dart';

dynamic settingsRepository;
dynamic playlistRepository;
dynamic usersRepository;
dynamic songsRepository;

Future<void> initProvidersRepositories() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    Directory directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  FirebaseProvider firebaseProvider = FirebaseProvider();
  HiveProvider hiveProvider = HiveProvider();

  settingsRepository = SettingsRepository(
    hiveProvider: hiveProvider,
  );

  songsRepository = SongsRepository(
    firebaseProvider: firebaseProvider,
    hiveProvider: hiveProvider,
  );
  await songsRepository.loadSongsFromFirebase();
  playlistRepository = PlaylistRepository(
    hiveProvider: hiveProvider,
    firebaseProvider: firebaseProvider,
  );
  usersRepository = UsersRepository(
    hiveProvider: hiveProvider,
    firebaseProvider: firebaseProvider,
  );
}
