// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final String selectedSongId;
  final List<Song> listSong;
  final bool isEditIconVisible;
  final List<String> listExpandedSongs;
  final TypeUser typeUser;

  const HomePageState({
    required this.selectedSongId,
    required this.listSong,
    required this.listExpandedSongs,
    required this.isEditIconVisible,
    required this.typeUser,
  });

  @override
  List<Object> get props => [selectedSongId, listSong, listExpandedSongs, isEditIconVisible, typeUser];

  HomePageState copyWith({
    String? selectedSongId,
    List<Song>? listSong,
    bool? isEditIconVisible,
    List<String>? listExpandedSongs,
    TypeUser? typeUser,
  }) {
    return HomePageState(
      selectedSongId: selectedSongId ?? this.selectedSongId,
      listSong: listSong ?? this.listSong,
      isEditIconVisible: isEditIconVisible ?? this.isEditIconVisible,
      listExpandedSongs: listExpandedSongs ?? this.listExpandedSongs,
      typeUser: typeUser ?? this.typeUser,
    );
  }
}

class HomePageInitial extends HomePageState {
  const HomePageInitial({
    required super.isEditIconVisible,
    required super.selectedSongId,
    required super.listSong,
    required super.listExpandedSongs,
    required super.typeUser,
  });
}
