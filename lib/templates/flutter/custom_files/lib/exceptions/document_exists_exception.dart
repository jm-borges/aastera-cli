// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class DocumentExistsException extends KnownException {
  String message;
  bool shouldNotify = false;

  DocumentExistsException({
    this.message =
        'Esse e-mail ou documento já está cadastrado. Em caso de dúvidas, entre em contato conosco.',
  });

  @override
  String toString() {
    return message;
  }
}
