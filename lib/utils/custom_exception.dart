class CustomException implements Exception {
  final dynamic message;

  CustomException(this.message);

  @override
  String toString() {
    if (message == null) return "Something went wrong, please try again.";
    return message;
  }
}
