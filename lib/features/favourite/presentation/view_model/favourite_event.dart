import 'package:equatable/equatable.dart';
import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object?> get props => [];
}

// Event to Add a Favourite
class AddToFavourites extends FavouriteEvent {
  final PostEntity post;
  const AddToFavourites(this.post);

  @override
  List<Object?> get props => [post];
}

// Event to Remove a Favourite
class RemoveFromFavourites extends FavouriteEvent {
  final PostEntity post;
  const RemoveFromFavourites(this.post);

  @override
  List<Object?> get props => [post];
}

// Event to Load Favourites
class LoadFavourites extends FavouriteEvent {}
