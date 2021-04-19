

class CloudException implements Exception {

  int code;
  String message;

  CloudException([this.code = -1, this.message]);

  @override
  String toString() {
    return message;
  }

}