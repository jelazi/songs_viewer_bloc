import 'package:default_project/repositories/songs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/song/song.dart';

part 'edit_song_event.dart';
part 'edit_song_state.dart';

class EditSongBloc extends Bloc<EditSongEvent, EditSongState> {
  SongsRepository songsRepository;
  EditSongBloc({required this.songsRepository}) : super(EditSongInitial(currentEditSong: Song.empty())) {
    on<ChangeEditSong>(_changeEditSong);
    on<ChangeSongValue>(_changeSongValue);
    on<CheckModifiedSong>(_checkModifiedSong);
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
}
