// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class NotFoundException extends KnownException {
  String message;

  NotFoundException({
    this.message =
        'O registro que você tentou acessar não foi encontrado. É possível que ele tenha sido removido. Em caso de dúvidas, entre em contato com a administração ou com o suporte técnico.',
  });

  @override
  String toString() {
    return message;
  }
}
