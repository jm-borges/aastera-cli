import 'package:args/args.dart';
import 'commands/init_command.dart';

Future<void> runCli(List<String> arguments) async {
  final argResults = parseArgs(arguments);

  if (argResults.command?.name == 'init') {
    await handleInitCommand(argResults.command!);
  } else {
    printUsage();
  }
}

ArgResults parseArgs(List<String> arguments) {
  final parser = ArgParser();

  parser.addCommand('init')
    ..addOption('type', abbr: 't', help: 'Tipo de projeto: flutter ou laravel')
    ..addOption('name', abbr: 'n', help: 'Nome do projeto');

  return parser.parse(arguments);
}

void printUsage() {
  print('''
Uso:
  aastera init -t flutter -n nome_projeto
  aastera init -t laravel -n nome_projeto

Opções:
  -t, --type    Tipo de projeto (flutter ou laravel)
  -n, --name    Nome do projeto
''');
}
