import 'package:equatable/equatable.dart';
import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';

class FavouriteState extends Equatable {
  final List<PostEntity> favouritePosts;
  final bool isLoading;

  const FavouriteState({required this.favouritePosts, required this.isLoading,});

  @override
  List<Object> get props => [favouritePosts,isLoading];
}
