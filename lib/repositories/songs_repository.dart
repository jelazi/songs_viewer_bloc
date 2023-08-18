// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../model/song/song.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';
import 'package:collection/collection.dart';

class SongsRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;

  final _songs = <Song>[];

  List<Song> get songs {
    return _songs;
  }

  SongsRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider;

  Future<void> loadSongsFromFirebase() async {
    final newSongs = await _firebaseProvider.getListSongsFromFirestore();
    for (Song song in newSongs) {
      if (_songs.firstWhereOrNull((val) => val.id == song.id) == null) {
        _songs.add(song);
      } else {
        //TODO: update song from firebase;
      }
    }
  }
}
