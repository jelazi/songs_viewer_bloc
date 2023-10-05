import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_logs/f_logs.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/playlist.dart';
import '../model/song/song.dart';
import '../model/user.dart';

class FirebaseProvider {
  CollectionReference<Map<String, dynamic>> songCollection = FirebaseFirestore.instance.collection('songs');
  CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection('users');
  CollectionReference<Map<String, dynamic>> playlistCollection = FirebaseFirestore.instance.collection('playlists');
  CollectionReference<Map<String, dynamic>> groupCollection = FirebaseFirestore.instance.collection('groups');
  FirebaseFirestore inst = FirebaseFirestore.instance;
  final DatabaseReference selectedSong = FirebaseDatabase.instance.ref().child('currentSong');

  FirebaseProvider() {
    inst.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    songCollection = inst.collection('songs');
    userCollection = inst.collection('users');
    playlistCollection = inst.collection('playlists');
    groupCollection = inst.collection('groups');
    selectedSong.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        //TODO: listener for current song on database
      }
    });
  }

  Future<void> addUserToFirebase(User user) async {
    try {
      var snapshot = await userCollection.doc(user.name).get();
      if (snapshot.exists) {
        updateUser(user);
      } else {
        await userCollection.doc(user.name).set(user.toJson());
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  void saveNewSelectedSong(String id) {
    selectedSong.update({'song': id});
  }

  void removeSelectedSong() {
    selectedSong.update({'song': ''});
  }

  void updateUser(User user) async {
    try {
      await userCollection.doc(user.name).update(user.toJson());
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  Future<List<User>> getListUsersFromFirestore() async {
    List<User> listUsers = [];
    try {
      var querySnapshot = await userCollection.get();
      for (var doc in querySnapshot.docs) {
        listUsers.add(User.fromJson(doc.data()));
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
    return listUsers;
  }

  Future<List<String>> getListSongGroupFromFirestore() async {
    List<String> listSongGroup = [];
    try {
      var snapshot = await groupCollection.doc('groups').get();
      if (snapshot.exists) {
        Map<String, dynamic>? map = snapshot.data();
        List<dynamic> groups = map?['groups'];
        listSongGroup = groups.map((e) => e.toString()).toList();
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
    return listSongGroup;
  }

  Future<void> deleteUser(User user) async {
    try {
      var snapshot = await userCollection.doc(user.name).get();
      if (snapshot.exists) {
        await userCollection.doc(user.name).delete();
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  Future<void> addSongToFirebase(Song songData) async {
    try {
      var snapshot = await songCollection.doc(songData.id).get();
      if (snapshot.exists) {
        updateSong(songData);
      } else {
        await songCollection.doc(songData.id).set(songData.toJson());
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  void updateSong(Song songData) async {
    try {
      await songCollection.doc(songData.id).update(songData.toJson());
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  Future<List<Song>> getListSongsFromFirestore() async {
    List<Song> listSongs = [];
    try {
      var querySnapshot = await songCollection.get();
      for (var doc in querySnapshot.docs) {
        listSongs.add(Song.fromJson(doc.data()));
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
    return listSongs;
  }

  Future<void> deleteSong(Song song) async {
    try {
      var snapshot = await songCollection.doc(song.id).get();
      if (snapshot.exists) {
        await songCollection.doc(song.id).delete();
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  Future<void> addPlaylistToFirebase(Playlist playlist) async {
    try {
      var snapshot = await playlistCollection.doc(playlist.id).get();
      if (snapshot.exists) {
        updatePlaylist(playlist);
      } else {
        await playlistCollection.doc(playlist.id).set(playlist.toJson());
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  void updatePlaylist(Playlist playlist) async {
    try {
      await playlistCollection.doc(playlist.id).update(playlist.toJson());
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  void addGroupsToFirebase(List<String> listGroup) async {
    Map<String, Object> map = {'groups': listGroup};
    try {
      var snapshot = await groupCollection.doc('groups').get();
      if (snapshot.exists) {
        await groupCollection.doc('groups').update(map);
      } else {
        await groupCollection.doc('groups').set(map);
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }

  Future<List<Playlist>> getListPlaylistsFromFirestore() async {
    List<Playlist> listPlaylists = [];
    try {
      var querySnapshot = await playlistCollection.get();
      for (var doc in querySnapshot.docs) {
        listPlaylists.add(Playlist.fromJson(doc.data()));
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
    return listPlaylists;
  }

  Future<void> deletePlaylist(Playlist playlist) async {
    try {
      var snapshot = await playlistCollection.doc(playlist.id).get();
      if (snapshot.exists) {
        await playlistCollection.doc(playlist.id).delete();
      }
    } catch (e) {
      FLog.error(text: '$e');
    }
  }
}
