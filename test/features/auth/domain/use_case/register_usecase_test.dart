import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/core/error/failure.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/register_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

// ✅ Define a Fake class for AuthEntity
class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late RegisterUseCase registerUseCase;

  setUpAll(() {
    // ✅ Register fallback value for AuthEntity
    registerFallbackValue(FakeAuthEntity());
  });

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    registerUseCase = RegisterUseCase(repository);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right('mocked_token'));
  });

  // ✅ Create valid RegisterUserParams
  const params = RegisterUserParams(
    fullName: "John Doe",
    username: "johndoe",
    password: "password123",
    phone: "1234567890",
    location: "New York",
    image: "profile.jpg",
  );

  test('Test 7 : should register user successfully and save token', () async {
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await registerUseCase(params);

    expect(result, const Right(null));

    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Test 8:should return ApiFailure when user registration fails', () async {
    final failure = ApiFailure(message: "Registration failed");
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => Left(failure));

    final result = await registerUseCase(params);

    expect(result, Left(failure));

    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
