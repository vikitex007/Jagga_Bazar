import '../repository/favourite_repository.dart';

class RemoveFromFavourite {
  final FavouriteRepository repository;

  RemoveFromFavourite(this.repository);

  Future<void> call(String postId) {
    return repository.removeFromFavourites(postId);
  }
}
