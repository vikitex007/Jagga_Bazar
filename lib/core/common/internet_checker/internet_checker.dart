class Failure {
  final String message;
  final int? statusCode;
  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}
// Local Database ko failure ko message
class LocalDatabaseFailure extends Failure{
  LocalDatabaseFailure({
    required super.message,
  });
}

// Api ko failure ko message
class ApiFailure extends Failure{


  final int statusCode;

  ApiFailure({
    required this.statusCode,
    required super.message,
  });
}