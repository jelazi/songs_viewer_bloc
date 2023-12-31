import 'dart:async';

import 'package:collection/collection.dart';
import 'package:default_project/repositories/settings_repository.dart';
import 'package:logger_pkg/logger_pkg.dart';

import '../model/user.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';

class UsersRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;
  final SettingsRepository settingsRepository;
  TypeUser currentTypeUser = TypeUser.none;

  final userController = StreamController<TypeUser>.broadcast();
  Stream<TypeUser> get selectSongData => userController.stream.asBroadcastStream();

  final _users = <User>[
    User('test', 'test')..typeUser = TypeUser.admin,
    User('josef', 'jk')..typeUser = TypeUser.viewer,
  ];

  UsersRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
    required this.settingsRepository,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider;

  Future<void> loadUsersFromFirebase() async {
    try {
      final users = await _firebaseProvider.userCollection.get();
      for (var user in users.docs) {
        final userObject = User.fromJson(user.data());
        _users.add(userObject);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadCurrentUser() async {
    User? user = await _hiveProvider.getCurrentUser();
    if (user == null) {
      return;
    }
    if (checkUser(user.name, user.password, isFromHive: true)) {
      logger.d('User ${user.name} is logged in');
    } else {
      logger.d('User ${user.name} is not logged in');
    }
  }

  bool checkUser(String username, String password, {bool isFromHive = false}) {
    final user = _users.firstWhereOrNull((element) => element.name == username);
    final userWithPassword = _users.firstWhereOrNull((element) => element.name == username && element.password == password);

    if (user == null) {
      logger.d('User $username does not exist');
      return false;
    }
    if (userWithPassword == null) {
      logger.d('User $username has wrong password');
      return false;
    }
    logger.d('User $username has correct password');
    if (!isFromHive) {
      settingsRepository.setCurrentUser(user);
    }
    currentTypeUser = user.typeUser;
    userController.sink.add(user.typeUser);
    return true;
  }
}
