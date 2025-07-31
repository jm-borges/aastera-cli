// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class NoConnectionException extends KnownException {
  String message;
  bool shouldNotify = false;

  NoConnectionException({
    this.message = 'Parece que você não está conectado à internet.',
  });

  @override
  String toString() {
    return message;
  }
}
