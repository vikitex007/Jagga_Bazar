import '../entity/favourite_post_entity.dart';

abstract class FavouriteRepository {
  Future<void> addToFavourites(FavouritePostEntity post);
  Future<void> removeFromFavourites(String postId);
  Future<List<FavouritePostEntity>> getFavouritePosts();
}
