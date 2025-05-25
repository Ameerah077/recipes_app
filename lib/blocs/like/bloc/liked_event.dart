part of 'liked_bloc.dart';

sealed class LikedEvent extends Equatable {
  const LikedEvent();

  @override
  List<Object> get props => [];
}

class LikeRecipe extends LikedEvent {
  final String title;

  const LikeRecipe(this.title);

  @override
  List<Object> get props => [title];
}

class UnlikeRecipe extends LikedEvent {
  final String title;

  const UnlikeRecipe(this.title);

  @override
  List<Object> get props => [title];
}
