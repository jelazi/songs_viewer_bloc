import '../model/user.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';

class UsersRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;

  final _users = <User>[];

  UsersRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider;
}
