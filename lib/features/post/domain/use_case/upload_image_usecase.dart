import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jagga_bazar/core/error/failure.dart';
import 'package:jagga_bazar/features/post/domain/repository/post_repository.dart';

import '../../../../app/usecase/usecase.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUseCase
    implements UsecaseWithParams<String, UploadImageParams> {
  late final IPostRepository _repository;

  UploadImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadPicture(params.file);
  }
}
