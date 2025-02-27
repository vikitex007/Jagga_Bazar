import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(const FavouriteState(favouritePosts: [], isLoading: false)) {
    on<AddToFavourites>(_onAddToFavourites);
    on<RemoveFromFavourites>(_onRemoveFromFavourites);
    on<LoadFavourites>(_onLoadFavourites);
  }

  void _onAddToFavourites(AddToFavourites event, Emitter<FavouriteState> emit) {
    if (!state.favouritePosts.contains(event.post)) {
      emit(FavouriteState(favouritePosts: [...state.favouritePosts, event.post], isLoading: true));
    }
  }

  void _onRemoveFromFavourites(RemoveFromFavourites event, Emitter<FavouriteState> emit) {
    emit(FavouriteState(
      favouritePosts: state.favouritePosts.where((p) => p.id != event.post.id).toList(), isLoading: true,
    ));
  }

  void _onLoadFavourites(LoadFavourites event, Emitter<FavouriteState> emit) {
    // Here you can fetch favourites from local storage if needed
    emit(state);
  }
}
