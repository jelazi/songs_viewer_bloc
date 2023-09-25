part of 'home_page_bloc.dart';

class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class _Init extends HomePageEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class FilterSong extends HomePageEvent {
  final String filter;

  const FilterSong({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];
}
