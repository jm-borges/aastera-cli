import 'package:path/path.dart' as p;
import 'dart:io';
import '../utils/file_utils.dart';
import '../utils/exec.dart';

Future<void> initLaravelProject(String name) async {
  final templatePath = p.join(
    Directory.current.path,
    'templates',
    'laravel',
    'custom_files',
  );
  final outputPath = p.join(Directory.current.path, name);

  print('🔧 Criando projeto Laravel "$name"...');

  await exec('composer create-project laravel/laravel $name');
  await copyTemplateFiles(templatePath, outputPath);

  print('✅ Projeto Laravel "$name" criado com template Aastera.');
}
