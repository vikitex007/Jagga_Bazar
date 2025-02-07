import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/core/error/failure.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'auth_repo.mock.dart';

// ✅ Mock class for File
class MockFile extends Mock implements File {}

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase usecase;
  late MockFile mockFile;

  setUpAll(() {
    registerFallbackValue(MockFile());
  });

  setUp(() {
    repository = MockAuthRepository();
    usecase = UploadImageUsecase(repository);
    mockFile = MockFile();
  });

  test('Test:9 should upload image successfully', () async {
    // Arrange
    when(() => repository.uploadProfilePicture(any())).thenAnswer(
          (_) async => const Right("uploaded_image_url"),
    );

    // Act
    final params = UploadImageParams(file: mockFile);  // Corrected here
    final result = await usecase(params);

    // Assert
    expect(result, const Right("uploaded_image_url"));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });

  // ✅ Test for failure case
  test('Test 10:should return ApiFailure when image upload fails', () async {
    // Arrange
    final failure = ApiFailure(message: "Image upload failed");
    when(() => repository.uploadProfilePicture(any())).thenAnswer(
          (_) async => Left(failure),
    );

    // Act
    final params = UploadImageParams(file: mockFile);  // Corrected here
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
