// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class DuplicateUserException extends KnownException {
  String message;
  bool shouldNotify = false;

  DuplicateUserException({
    this.message =
        'Parece que um usuário com esse e-mail e/ou documento já está cadastrado. Em caso de dúvidas, entre em contato conosco.',
  });

  @override
  String toString() {
    return message;
  }
}
