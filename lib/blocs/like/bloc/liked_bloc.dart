import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'liked_event.dart';
part 'liked_state.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  LikedBloc() : super(const LikedState()) {
    on<LikeRecipe>((event, emit) {
      final updated = Set<String>.from(state.likedTitles)..add(event.title);
      emit(state.copyWith(likedTitles: updated));
    });

    on<UnlikeRecipe>((event, emit) {
      final updated = Set<String>.from(state.likedTitles)..remove(event.title);
      emit(state.copyWith(likedTitles: updated));
    });
  }
}
