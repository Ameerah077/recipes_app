part of 'liked_bloc.dart';

class LikedState extends Equatable {
  final Set<String> likedTitles;

  const LikedState({this.likedTitles = const {}});

  LikedState copyWith({Set<String>? likedTitles}) {
    return LikedState(likedTitles: likedTitles ?? this.likedTitles);
  }

  @override
  List<Object> get props => [likedTitles];
}
