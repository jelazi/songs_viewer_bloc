import 'package:default_project/blocs/export_blocs.dart';
import 'package:default_project/repositories/settings_repository.dart';
import 'package:default_project/repositories/songs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger_pkg/logger_pkg.dart';

import '../../../model/song/song.dart';
import '../../../services/enums.dart';
import '../../../view/mobile_view/widgets/chords_lyric/chord_parser.dart' as chordParser;

part 'edit_song_event.dart';
part 'edit_song_state.dart';

class EditSongBloc extends Bloc<EditSongEvent, EditSongState> {
  SongsRepository songsRepository;
  SettingsRepository settingsRepository;
  EditSongBloc({required this.songsRepository, required this.settingsRepository})
      : super(EditSongInitial(
            currentEditSong: Song.empty(),
            textStyle: const TextStyle(),
            chordStyle: const TextStyle(),
            selectChord: '',
            listUniqueChords: const [],
            transposeIncrement: 0,
            selectChordIndex: -1,
            listUniqueChordsIsVisible: false,
            currentText: '',
            listSelectedChords: [])) {
    on<_Init>(_init);
    on<ChangeEditSong>(_changeEditSong);
    on<ChangeSongValue>(_changeSongValue);
    on<CheckModifiedSong>(_checkModifiedSong);
    on<ResetValue>(_resetValue);
    on<TransposeChordPermanent>(_transposeChords);
    on<ChangeFontSizeEdit>(_changeFontSizeEdit);
    on<SelectChord>(_selectChord);
    on<ChangeListUniqueChordsIsVisible>(_changeListUniqueChordsIsVisible);
    on<UpdateListUniqueChords>(_updateListUniqueChords);
    on<ChangePositionChord>(_changePositionChord);
    add(const _Init());
  }

  void _init(_Init event, Emitter<EditSongState> emit) {
    final state = this.state;
    emit(state.copyWith(
        textStyle: TextStyle(fontSize: settingsRepository.previewFontTextSize, color: settingsRepository.previewColorText),
        chordStyle: TextStyle(fontSize: settingsRepository.previewFontChordSize, color: settingsRepository.previewColorChord)));
  }

  void _changeEditSong(ChangeEditSong event, Emitter<EditSongState> emit) {
    final state = this.state;
    if (state.textStyle.color != settingsRepository.previewColorText ||
        state.textStyle.fontSize != settingsRepository.previewFontTextSize ||
        state.chordStyle.color != settingsRepository.previewColorChord ||
        state.chordStyle.fontSize != settingsRepository.previewFontChordSize) {
      emit(state.copyWith(
          currentEditSong: event.song,
          listUniqueChords: event.song.getAllUniqueChordsFromSong(TypeLyric.original),
          textStyle: TextStyle(fontSize: settingsRepository.previewFontTextSize, color: settingsRepository.previewColorText),
          currentText: event.song.lyrics,
          chordStyle: TextStyle(
            fontSize: settingsRepository.previewFontChordSize,
            color: settingsRepository.previewColorChord,
          )));
    } else {
      emit(state.copyWith(currentText: event.song.lyrics, currentEditSong: event.song, listUniqueChords: event.song.getAllUniqueChordsFromSong(TypeLyric.original)));
    }
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
      final listModified = oldSong.checkModifiedSong(state.currentEditSong, false);
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

  void _transposeChords(TransposeChordPermanent event, Emitter<EditSongState> emit) {
    final state = this.state;
    var lyric = event.isOriginalLyric ? state.currentEditSong.originalLyrics ?? '' : state.currentEditSong.lyrics;
    var newLyric = '';
    try {
      RegExp exp = RegExp(r'\[.?.?.?.?.?\]');

      newLyric = lyric.replaceAllMapped(exp, (match) {
        String? result = (match.group(0));

        if (result == null) return '';
        result = result.replaceFirst(RegExp(r'\['), '');
        result = result.replaceFirst(RegExp(r'\]'), '');
        result = chordParser.ChordProcessor.transposeChord(result, event.transposeIncrement, TypeTranspose.czech);
        result = '[$result]';
        return result;
      });
    } catch (e) {}

    final Song newSong = state.currentEditSong.copyWith(
      lyrics: event.isOriginalLyric ? state.currentEditSong.lyrics : newLyric,
      originalLyrics: event.isOriginalLyric ? newLyric : state.currentEditSong.originalLyrics,
    );
    final listUniqueChords = newSong.getAllUniqueChordsFromSong(event.isOriginalLyric ? TypeLyric.original : TypeLyric.translate);
    emit(state.copyWith(
        currentEditSong: state.currentEditSong.copyWith(lyrics: newLyric), listUniqueChords: listUniqueChords, selectChord: '', transposeIncrement: event.transposeIncrement));
  }

  void _changeFontSizeEdit(ChangeFontSizeEdit event, Emitter<EditSongState> emit) {
    final state = this.state;
    double fontSize = state.textStyle.fontSize!;
    double chordSize = state.chordStyle.fontSize!;
    if (event.isIncrease) {
      fontSize++;
      chordSize++;
    } else {
      fontSize--;
      chordSize--;
    }
    settingsRepository.changeSettingsValue('fontTextSize', fontSize);
    settingsRepository.changeSettingsValue('fontChordSize', chordSize);
    emit(state.copyWith(textStyle: state.textStyle.copyWith(fontSize: fontSize), chordStyle: state.chordStyle.copyWith(fontSize: chordSize)));
  }

  void _selectChord(SelectChord event, Emitter<EditSongState> emit) {
    final state = this.state;

    var list = List<int>.from(state.listSelectedChords);
    if (list.contains(event.index)) {
      list.remove(event.index);
    } else {
      list.add(event.index);
    }
    emit(state.copyWith(listSelectedChords: list));
  }

  void _changeListUniqueChordsIsVisible(ChangeListUniqueChordsIsVisible event, Emitter<EditSongState> emit) {
    final state = this.state;
    emit(state.copyWith(listUniqueChordsIsVisible: event.isVisible));
  }

  void _updateListUniqueChords(UpdateListUniqueChords event, Emitter<EditSongState> emit) {
    final state = this.state;
    final listUniqueChords = state.currentEditSong.getAllUniqueChordsFromSong(event.typeLyric);
    emit(state.copyWith(listUniqueChords: listUniqueChords));
  }

  void _changePositionChord(ChangePositionChord event, Emitter<EditSongState> emit) {
    final state = this.state;
    var text = state.currentText;
    final lastIndex = event.index;
    var firstIndex = event.index;
    for (int i = lastIndex; i >= 0; i--) {
      if (text[i] == '[') {
        firstIndex = i;
        break;
      }
    }
    var newFirstIndex = firstIndex;
    if (event.increase) {
      if (lastIndex == text.length - 1) {
        return;
      }
      final chord = text.substring(firstIndex, lastIndex + 1);
      text = text.replaceRange(firstIndex, lastIndex + 1, '');
      newFirstIndex = firstIndex + 1;
      if (text[firstIndex + 1] == '[') {
        for (int i = firstIndex + 1; i < text.length; i++) {
          if (text[i] == ']') {
            newFirstIndex = i + 1;
            break;
          }
        }
      }
      text = text.replaceRange(newFirstIndex, newFirstIndex, chord);
    } else {
      if (firstIndex == 0) {
        return;
      }
      final chord = text.substring(firstIndex, lastIndex + 1);
      text = text.replaceRange(firstIndex, lastIndex + 1, '');
      newFirstIndex = firstIndex - 1;
      if (text[firstIndex - 1] == ']') {
        for (int i = firstIndex - 1; i >= 0; i--) {
          if (text[i] == '[') {
            newFirstIndex = i;
            break;
          }
        }
      }
      text = text.replaceRange(newFirstIndex, newFirstIndex, chord);
    }
    var list = List<int>.from(state.listSelectedChords);
    var newLastIndex = lastIndex + (newFirstIndex - firstIndex);
    // remove old index
    list.remove(event.index);
    // add new index
    list.add(newLastIndex);

    emit(state.copyWith(currentText: text, listSelectedChords: list));
  }
}
