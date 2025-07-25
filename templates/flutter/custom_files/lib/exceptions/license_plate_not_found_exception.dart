// ignore_for_file: overridden_fields, annotate_overrides
import 'known_exception.dart';

class LicensePlateNotFoundException extends KnownException {
  String message;

  LicensePlateNotFoundException({
    this.message =
        'Essa placa não foi encontrada. Você tem certeza que digitou corretamente?',
  });

  @override
  String toString() {
    return message;
  }
}
