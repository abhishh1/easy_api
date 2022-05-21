class EasyException implements Exception {
  final String message;
  EasyException(this.message);
}

class ServerException extends EasyException {
  ServerException() : super("Server failure error, Try later");
}

class NoInternetException extends EasyException {
  NoInternetException() : super("Internet not available");
}

class FetchDataException extends EasyException {
  FetchDataException() : super("Error During Communication");
}

class BadRequestException extends EasyException {
  BadRequestException() : super("Invalid Request");
}

class UnauthorizedException extends EasyException {
  UnauthorizedException() : super("Unauthorized");
}

class FormatInputException extends EasyException {
  FormatInputException() : super("Invalid Input");
}

class AnonymousException extends EasyException {
  AnonymousException() : super("Something went wrong!");
}

class CustomPlatformException extends EasyException {
  CustomPlatformException() : super("Something went wrong!");
}
