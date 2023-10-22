part of 'edit_song_bloc.dart';

class EditSongEvent extends Equatable {
  const EditSongEvent();

  @override
  List<Object> get props => [];
}

class _Init extends EditSongEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class ChangeEditSong extends EditSongEvent {
  final Song song;
  const ChangeEditSong({required this.song});
}

class ChangeSongValue extends EditSongEvent {
  final String value;
  final String nameValue;
  const ChangeSongValue({required this.value, required this.nameValue});
}

class CheckModifiedSong extends EditSongEvent {
  const CheckModifiedSong();
}

class ResetValue extends EditSongEvent {
  final String nameValue;
  const ResetValue({required this.nameValue});
  @override
  List<Object> get props => [nameValue];
}
