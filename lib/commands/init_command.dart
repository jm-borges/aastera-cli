import 'package:aastera/cli.dart';
import 'package:aastera/flutter.dart';
import 'package:aastera/laravel.dart';
import 'package:args/args.dart';

Future<void> handleInitCommand(ArgResults args) async {
  final type = args['type'];
  final name = args['name'];

  if (type == null || name == null) {
    printUsage();
    return;
  }

  switch (type) {
    case 'flutter':
      await initFlutterProject(name);
      break;
    case 'laravel':
      await initLaravelProject(name);
      break;
    default:
      print('❌ Tipo de projeto inválido: $type');
  }
}
