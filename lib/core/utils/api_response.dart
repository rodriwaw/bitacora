abstract class ApiResponse {
  final bool status;
  final String message;

  ApiResponse(this.status, this.message);

  @override
  String toString() => message;
}

class Failure extends ApiResponse {
  Failure(super.status, super.message);
}

class Success extends ApiResponse {
  Success(super.status, super.message);
}
