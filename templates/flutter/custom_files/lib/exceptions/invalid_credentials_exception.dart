// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class InvalidCredentialsException extends KnownException {
  String message;
  bool shouldNotify = false;

  InvalidCredentialsException({
    this.message = 'Essas credenciais não foram encontradas.',
  });

  @override
  String toString() {
    return message;
  }
}
