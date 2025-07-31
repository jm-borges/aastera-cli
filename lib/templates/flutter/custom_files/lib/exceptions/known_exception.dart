abstract class KnownException implements Exception {
  String message = 'Houve um erro ao realizar essa ação';
  bool shouldNotify = true;
}
