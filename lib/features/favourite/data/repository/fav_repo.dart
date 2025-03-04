import 'package:jagga_bazar/core/network/hive_service.dart';
import '../../domain/entity/favourite_post_entity.dart';
import '../../domain/repository/favourite_repository.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final HiveService hiveService;

  FavouriteRepositoryImpl(this.hiveService);

  @override
  Future<void> addToFavourites(FavouritePostEntity post) {
    return hiveService.addToFavourites(post);
  }

  @override
  Future<List<FavouritePostEntity>> getFavouritePosts() {
    return hiveService.getFavouritePosts();
  }

  @override
  Future<void> removeFromFavourites(String postId) {
    return hiveService.removeFromFavourites(postId);
  }
}
