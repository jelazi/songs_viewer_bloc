// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_song_bloc.dart';

class EditSongState extends Equatable {
  final Song currentEditSong;
  final TextStyle textStyle;
  final TextStyle chordStyle;
  const EditSongState({
    required this.currentEditSong,
    required this.textStyle,
    required this.chordStyle,
  });

  @override
  List<Object> get props => [currentEditSong];

  EditSongState copyWith({
    Song? currentEditSong,
    TextStyle? textStyle,
    TextStyle? chordStyle,
  }) {
    return EditSongState(
      currentEditSong: currentEditSong ?? this.currentEditSong,
      textStyle: textStyle ?? this.textStyle,
      chordStyle: chordStyle ?? this.chordStyle,
    );
  }
}

class EditSongInitial extends EditSongState {
  const EditSongInitial({required super.currentEditSong, required super.textStyle, required super.chordStyle});
}
