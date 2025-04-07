class ApiException implements Exception {
  ApiException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends ApiException {
  InternetException([String? message]) : super(message, 'No Internet : ');
}

class ServerException extends ApiException {
  ServerException([String? message])
      : super(message, 'Internal Server Error : ');
}

class UnProcessableEntityException extends ApiException {
  UnProcessableEntityException([String? message]) : super(message, '');
}

class RequestTimeoutException extends ApiException {
  RequestTimeoutException([String? message])
      : super(message, 'Request Time Out : ');
}

// class ChecklistAlreadySubmittedException extends ApiException {
//   ChecklistAlreadySubmittedException(this.message);
//   final String message;
//
//   @override
//   String toString() => 'ChecklistAlreadySubmittedException: $message';
// }

class NetworkApiException implements Exception {
  NetworkApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'NetworkApiException: $statusCode - $message';
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message, 'Invalid Request : ');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, '');
}

class UnauthorisedRequestException extends ApiException {
  UnauthorisedRequestException(String message)
      : super(message, 'Unauthorised Request : ');
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input : ');
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, 'Error while connecting,  Please check your Internet.');
}

class DefaultException extends ApiException {
  DefaultException([String? message]) : super(message, '');
}
