import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/common/internet_checker/internet_checker.dart';
import '../../core/error/failure.dart';


//
// abstract interface class UsecaseWithParams<SuccessType, Params> {
//   Future<Either<Failure, SuccessType>> call(Params params);
// }
//
// abstract interface class UsecaseWithoutParams<SuccessType> {
//   Future<Either<Failure, SuccessType>> call();
// }

class TokenSharedPrefs{
  final SharedPreferences _sharedPreferences;
  TokenSharedPrefs (this._sharedPreferences);

  Future<Either<Failure,void>> saveToken(String token) async{
    try {
      await _sharedPreferences.setString('token',token);
      return Right(null);
    }catch(e){
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure,String>> getToken()async{
    try{
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    }
    catch(e){
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }


}