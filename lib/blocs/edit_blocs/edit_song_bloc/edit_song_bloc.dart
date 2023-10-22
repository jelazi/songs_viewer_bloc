import 'package:default_project/repositories/settings_repository.dart';
import 'package:default_project/repositories/songs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/song/song.dart';

part 'edit_song_event.dart';
part 'edit_song_state.dart';

class EditSongBloc extends Bloc<EditSongEvent, EditSongState> {
  SongsRepository songsRepository;
  SettingsRepository settingsRepository;
  EditSongBloc({required this.songsRepository, required this.settingsRepository})
      : super(EditSongInitial(currentEditSong: Song.empty(), textStyle: const TextStyle(), chordStyle: const TextStyle())) {
    on<_Init>(_init);
    on<ChangeEditSong>(_changeEditSong);
    on<ChangeSongValue>(_changeSongValue);
    on<CheckModifiedSong>(_checkModifiedSong);
    on<ResetValue>(_resetValue);
    add(const _Init());
  }

  void _init(_Init event, Emitter<EditSongState> emit) {
    final state = this.state;
    emit(state.copyWith(
        textStyle: TextStyle(fontSize: settingsRepository.fontTextSize, color: settingsRepository.colorText),
        chordStyle: TextStyle(fontSize: settingsRepository.fontChordSize, color: settingsRepository.colorChord)));
  }

  void _changeEditSong(ChangeEditSong event, Emitter<EditSongState> emit) {
    final state = this.state;
    emit(state.copyWith(currentEditSong: event.song));
  }

  void _changeSongValue(ChangeSongValue event, Emitter<EditSongState> emit) {
    final state = this.state;
    switch (event.nameValue) {
      case 'title':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              title: event.value,
            ),
          ));
          final song = songsRepository.getSongById(state.currentEditSong.id);
          if (song != null) {
            print(song == state.currentEditSong);
          }
          break;
        }
      case 'interpret':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              interpret: event.value,
            ),
          ));
          break;
        }
      case 'indexSongBook':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              indexSongBook: int.parse(event.value),
            ),
          ));
          break;
        }
      case 'lyrics':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              lyrics: event.value,
            ),
          ));
          break;
        }
      case 'originalLyrics':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              originalLyrics: event.value,
            ),
          ));
          break;
        }
    }
  }

  void _checkModifiedSong(CheckModifiedSong event, Emitter<EditSongState> emit) {
    final state = this.state;
    final oldSong = songsRepository.getSongById(state.currentEditSong.id);
    if (oldSong != null) {
      final listModified = oldSong.checkModifiedSong(state.currentEditSong);
      if (listModified.isNotEmpty) {
        print('Modified: $listModified');
      }
    }
  }

  void _resetValue(ResetValue event, Emitter<EditSongState> emit) {
    final state = this.state;
    final oldSong = songsRepository.getSongById(state.currentEditSong.id);
    switch (event.nameValue) {
      case 'lyrics':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              lyrics: oldSong?.lyrics ?? '',
            ),
          ));
          break;
        }
      case 'originalLyrics':
        {
          emit(state.copyWith(
            currentEditSong: state.currentEditSong.copyWith(
              originalLyrics: oldSong?.originalLyrics ?? '',
            ),
          ));
          break;
        }
    }
  }
}
