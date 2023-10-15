// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final HomePageProperties homePageProperties;
  final bool isEditIconVisible;

  const HomePageState({
    required this.homePageProperties,
    required this.isEditIconVisible,
  });

  @override
  List<Object> get props => [homePageProperties];

  HomePageState copyWith({
    HomePageProperties? homePageProperties,
    bool? isEditIconVisible,
  }) {
    return HomePageState(
      homePageProperties: homePageProperties ?? this.homePageProperties,
      isEditIconVisible: isEditIconVisible ?? this.isEditIconVisible,
    );
  }
}

class HomePageInitial extends HomePageState {
  const HomePageInitial({
    required super.homePageProperties,
    required super.isEditIconVisible,
  });
}

class HomePageProperties {
  final String? selectedSongId;
  List<Song> listSong;
  final bool isEditIconVisible;
  List<String> listExpandedSongs;

  HomePageProperties({
    this.selectedSongId,
    required this.listSong,
    required this.isEditIconVisible,
    required this.listExpandedSongs,
  });

  HomePageProperties copyWith({
    String? selectedSongId,
    List<Song>? listSong,
    bool? isEditIconVisible,
    List<String>? listExpandedSongs,
  }) {
    return HomePageProperties(
      selectedSongId: selectedSongId ?? this.selectedSongId,
      listSong: listSong ?? this.listSong,
      isEditIconVisible: isEditIconVisible ?? this.isEditIconVisible,
      listExpandedSongs: listExpandedSongs ?? this.listExpandedSongs,
    );
  }
}
