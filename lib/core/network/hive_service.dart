import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/auth_hive_model.dart';
import '../../features/favourite/data/model/favourite_post_model.dart';
import '../../features/favourite/domain/entity/favourite_post_entity.dart';
import '../../features/post/data/model/post_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize Hive with a custom path if necessary (optional step)
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/jagga_bazar_mobile.db';

    Hive.init(path);

    // Register all Hive adapters
    Hive.registerAdapter(PostHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(FavouritePostModelAdapter());
  }

  // ================= Post Queries =================
  Future<void> addPost(PostHiveModel post) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.put(post.postId, post);
  }

  Future<void> deletePost(String id) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.delete(id);
  }

  Future<List<PostHiveModel>> getAllPosts() async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    return box.values.toList()..sort((a, b) => a.title.compareTo(b.title));
  }

  // ================= Auth Queries =================
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // ================= Favourite Queries =================

  /// Save entire list of favourite posts (bulk save)
  Future<void> saveFavouritePosts(List<FavouritePostEntity> posts) async {
    final box = await Hive.openBox<FavouritePostModel>(HiveTableConstant.favouritePostBox);
    await box.clear(); // Optional: Clear all old favourites (can be removed if you want to merge)
    await box.addAll(posts.map(FavouritePostModel.fromEntity));
  }

  /// Get all favourite posts
  Future<List<FavouritePostEntity>> getFavouritePosts() async {
    print('📦 HiveService: Opening favourite box...');
    final box = await Hive.openBox<FavouritePostModel>(HiveTableConstant.favouritePostBox);
    print('✅ HiveService: Opened box. Total items: ${box.length}');

    final posts = box.values.map((model) => model.toEntity()).toList();
    print('📌 HiveService: Converted ${posts.length} items to entities');

    return posts;
  }


  /// Add a single post to favourites
  Future<void> addToFavourites(FavouritePostEntity post) async {
    final box = await Hive.openBox<FavouritePostModel>(HiveTableConstant.favouritePostBox);
    if (!box.values.any((existingPost) => existingPost.id == post.id)) {
      await box.add(FavouritePostModel.fromEntity(post));
    }
  }

  /// Remove a post from favourites by ID
  Future<void> removeFromFavourites(String postId) async {
    final box = await Hive.openBox<FavouritePostModel>(HiveTableConstant.favouritePostBox);
    final key = box.keys.firstWhere(
          (key) {
        final post = box.get(key);
        return post?.id == postId;
      },
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  // ================= Login & Other Queries =================
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
          (element) => element.username == username && element.password == password,
      orElse: () => AuthHiveModel.initial(),
    );
    box.close();
    return user.userId == null ? null : user;  // Ensure null is returned if no user found
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.postBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.favouritePostBox);
  }

  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
