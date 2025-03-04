import '../entity/favourite_post_entity.dart';
import '../repository/favourite_repository.dart';

class GetFavouritePosts {
  final FavouriteRepository repository;

  GetFavouritePosts(this.repository);

  Future<List<FavouritePostEntity>> call() {
    return repository.getFavouritePosts();
  }
}
