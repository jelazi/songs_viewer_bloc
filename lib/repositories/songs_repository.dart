// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import '../model/song/song.dart';
import '../providers/firebase_provider.dart';
import '../providers/hive_provider.dart';
import 'package:collection/collection.dart';

class SongsRepository {
  final HiveProvider _hiveProvider;
  final FirebaseProvider _firebaseProvider;

  final selectSongController = StreamController<String>.broadcast();
  Stream<String> get selectSongData => selectSongController.stream.asBroadcastStream();

  final _songs = <Song>[];
  String selectedSongId = '';

  List<Song> get songs {
    return _songs;
  }

  SongsRepository({
    required HiveProvider hiveProvider,
    required FirebaseProvider firebaseProvider,
  })  : _hiveProvider = hiveProvider,
        _firebaseProvider = firebaseProvider {
    _init();
  }

  void _init() {
    _firebaseProvider.selectedSong.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map && data['song'] != null) {
        selectSongController.sink.add(data['song']);
        selectedSongId = data['song'];
      }
    });
  }

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

  void selectSong(String songId) {
    if (selectedSongId == songId) {
      selectedSongId = '';
      _firebaseProvider.removeSelectedSong();
      return;
    }
    selectedSongId = songId;
    _firebaseProvider.saveNewSelectedSong(songId);
  }

  List<Song> getSongByFilter(String filterSong) {
    List<Song> listSong = [];

    for (Song song in _songs) {
      if (containsString(filterSong, song)) {
        listSong.add(song);
      }
    }
    return listSong;
  }

  bool containsString(String filter, Song song) {
    String stringToLoverCase = removeDiacriticsAndWhitespace(filter.toLowerCase());
    String titleToLoverCase = removeDiacriticsAndWhitespace(song.title.toLowerCase());
    String lyricsToLoverCase = removeDiacriticsAndWhitespace(song.lyricsWithoutChords.toLowerCase());

    String interpretToLoverCase = removeDiacriticsAndWhitespace(song.interpret ?? ''.toLowerCase());

    if (titleToLoverCase.contains(stringToLoverCase) || lyricsToLoverCase.contains(stringToLoverCase) || interpretToLoverCase.contains(stringToLoverCase)) {
      return true;
    }
    for (String group in song.groups ?? []) {
      String groupToLoverCase = removeDiacriticsAndWhitespace(group.toLowerCase());
      if (groupToLoverCase.contains(stringToLoverCase)) {
        return true;
      }
    }
    for (String tag in song.tags ?? []) {
      String tagToLoverCase = removeDiacriticsAndWhitespace(tag.toLowerCase());
      if (tagToLoverCase.contains(stringToLoverCase)) {
        return true;
      }
    }
    if (filter.contains(song.indexSongBook.toString())) {
      return true;
    }

    return false;
  }

  String removeDiacriticsAndWhitespace(String str) {
    const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÝÿýŽžŘřŤťĚěČčŮůŇňĹĺ';
    const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYYyyZzRrTtEeCcUuNnLl';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    str = str.replaceAll(' ', '');

    return str;
  }
}
