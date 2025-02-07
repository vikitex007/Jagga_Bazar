import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

class CreatePostParams extends Equatable {
  final String title;
  final String description;
  final String price;
  final String? image;
  final bool negotiable;
  final String postedBy;
  final String? createdAt;

  const CreatePostParams({
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.negotiable = true,
    required this.postedBy,
    this.createdAt
  });

  // Empty constructor
  const CreatePostParams.empty()
      : title = '_empty.title',
        description = '_empty.description',
        price = '_empty.price',
        image = null,
        negotiable = true,
        postedBy = '_empty.postedBy',
        createdAt = null;

  @override
  List<Object?> get props => [title, description, price, image, negotiable, postedBy,createdAt];
}

class CreatePostUseCase implements UsecaseWithParams<void, CreatePostParams> {
  final IPostRepository postRepository;

  CreatePostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, void>> call(CreatePostParams params) async {
    return await postRepository.createPost(
      PostEntity(
        title: params.title,
        description: params.description,
        price: params.price,
        image: params.image,
        negotiable: params.negotiable,
        postedBy: params.postedBy,
        createdAt: "",
      ),
    );
  }
}
