import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/add_to_favourite.dart';
import '../../domain/use_case/get_favourite.dart';
import '../../domain/use_case/remove_from_favourite.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final GetFavouritePosts getFavourites;
  final AddToFavourite addToFavourite;
  final RemoveFromFavourite removeFromFavourite;

  FavouriteBloc({

    required this.getFavourites,
    required this.addToFavourite,
    required this.removeFromFavourite,
  }) : super(FavouriteLoading()) {
    print('🚀 FavouriteBloc created');
    on<LoadFavourites>(_onLoadFavourites);
    on<AddPostToFavourites>(_onAddToFavourites);
    on<RemovePostFromFavourites>(_onRemoveFromFavourites);
  }

  Future<void> _onLoadFavourites(
      LoadFavourites event,
      Emitter<FavouriteState> emit,
      ) async {
    print('📥 LoadFavourites event received in Bloc');
    emit(FavouriteLoading());
    print('⏳ Fetching favourite posts from Hive...');
    try {
      final favourites = await getFavourites();
      print('✅ Favourites fetched: ${favourites.length}');
      emit(FavouriteLoaded(favourites));
      print('🚀 Emitted FavouriteLoaded');
    } catch (e, stackTrace) {
      print('❌ Error fetching favourites: $e');
      print(stackTrace);
      emit(FavouriteError());
    }
  }




  Future<void> _onAddToFavourites(AddPostToFavourites event, Emitter<FavouriteState> emit) async {
    await addToFavourite(event.post);
    add(LoadFavourites());
  }

  Future<void> _onRemoveFromFavourites(RemovePostFromFavourites event, Emitter<FavouriteState> emit) async {
    await removeFromFavourite(event.postId);
    add(LoadFavourites());
  }
}
