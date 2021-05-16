

class CloudException implements Exception {

  int code;
  var message;

  CloudException([this.code = -1, this.message]);

  @override
  String toString() {
    return message;
  }

}