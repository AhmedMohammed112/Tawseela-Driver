class Failure implements Exception {
  final int? code;
  final String? message;

  Failure({this.code,this.message});
}

