import 'package:collection/collection.dart';

import '../model/user.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';

class UsersRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;

  final _users = <User>[User('test', 'test')];

  UsersRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider;

  bool checkUser(String username, String password) {
    final user = _users.firstWhereOrNull((element) => element.name == username);

    if (user != null && user.password == password) {
      return true;
    } else {
      return false;
    }
  }
}
