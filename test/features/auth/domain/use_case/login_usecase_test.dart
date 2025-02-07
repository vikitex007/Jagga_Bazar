import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/core/error/failure.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase loginUseCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(repository, tokenSharedPrefs);

    // ✅ Fix: Ensure `getToken()` returns a valid value
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right('mocked_token'));
  });

  test('Test 6: should call the [AuthRepo.login] with correct username and password', () async {
    // ✅ Mock loginUser behavior
    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (username == 'sachin07' && password == 'sachin123') {
        return const Right('token');
      } else {
        return const Left(ApiFailure(message: "Invalid username or password"));
      }
    });

    // ✅ Mock saveToken
    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    // ✅ Await the Future result
    final result = await loginUseCase(LoginParams(username: 'sachin07', password: 'sachin123'));

    // ✅ Assertions
    expect(result, const Right('token'));

    // ✅ Verify interactions
    verify(() => repository.loginUser(any(), any())).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
