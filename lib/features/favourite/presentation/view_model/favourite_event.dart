import '../../domain/entity/favourite_post_entity.dart';

abstract class FavouriteEvent {}

class LoadFavourites extends FavouriteEvent {}

class AddPostToFavourites extends FavouriteEvent {
  final FavouritePostEntity post;
  AddPostToFavourites(this.post);
}

class RemovePostFromFavourites extends FavouriteEvent {
  final String postId;
  RemovePostFromFavourites(this.postId);
}
