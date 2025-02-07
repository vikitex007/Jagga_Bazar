import 'package:jagga_bazar/app/shared_prefs/token_shared_prefs.dart';
import 'package:jagga_bazar/features/auth/domain/repository/auth_repository.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository{}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs{}

