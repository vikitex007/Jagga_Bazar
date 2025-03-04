import '../entity/favourite_post_entity.dart';
import '../repository/favourite_repository.dart';

class AddToFavourite {
  final FavouriteRepository repository;

  AddToFavourite(this.repository);

  Future<void> call(FavouritePostEntity post) {
    return repository.addToFavourites(post);
  }
}
