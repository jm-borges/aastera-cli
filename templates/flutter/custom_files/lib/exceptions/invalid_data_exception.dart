// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class InvalidDataException extends KnownException {
  String message;
  bool shouldNotify = false;

  InvalidDataException({this.message = 'Os dados enviados não são válidos.'});

  @override
  String toString() {
    return message;
  }
}
