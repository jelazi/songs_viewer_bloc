import '../model/playlist.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';

class PlaylistRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;

  final _playlists = <Playlist>[];

  PlaylistRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider;
}
