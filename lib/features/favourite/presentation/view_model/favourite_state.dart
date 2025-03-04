import '../../domain/entity/favourite_post_entity.dart';

abstract class FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<FavouritePostEntity> favourites;
  FavouriteLoaded(this.favourites);
}

class FavouriteError extends FavouriteState {}
