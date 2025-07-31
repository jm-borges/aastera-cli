// ignore_for_file: overridden_fields, annotate_overrides

import 'known_exception.dart';

class ApiLimitException extends KnownException {
  String message;

  ApiLimitException({
    this.message =
        'Parece que você superaqueceu o servidor. Aguarde um instante antes de seguir navegando no app',
  });

  @override
  String toString() {
    return message;
  }
}
