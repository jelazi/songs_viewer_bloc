// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final HomePageProperties homePageProperties;

  const HomePageState({
    required this.homePageProperties,
  });

  @override
  List<Object> get props => [homePageProperties];

  HomePageState copyWith({
    HomePageProperties? homePageProperties,
    bool? abbBarIsExpanded,
  }) {
    return HomePageState(
      homePageProperties: homePageProperties ?? this.homePageProperties,
    );
  }
}

class HomePageInitial extends HomePageState {
  const HomePageInitial({
    required super.homePageProperties,
  });
}

class HomePageProperties {
  List<Song> listSong;
  HomePageProperties({
    required this.listSong,
  });

  HomePageProperties copyWith({
    List<Song>? listSong,
  }) {
    return HomePageProperties(
      listSong: listSong ?? this.listSong,
    );
  }
}
