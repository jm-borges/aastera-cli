import 'package:path/path.dart' as p;
import 'dart:io';
import '../utils/file_utils.dart';
import '../utils/exec.dart';

Future<void> initLaravelProject(String name) async {
  final baseTemplatePath = p.join(
    Directory.current.path,
    'lib',
    'templates',
    'laravel',
  );
  final customFilesPath = p.join(baseTemplatePath, 'custom_files');
  final specialFilesPath = p.join(baseTemplatePath, 'special_files');
  final outputPath = p.join(Directory.current.path, name);

  print(outputPath);

  print('🔧 Criando projeto Laravel "$name"...');

  await exec('composer create-project laravel/laravel $name');
  await copyTemplateFiles(customFilesPath, outputPath);
  await exec("echo no | php artisan install:api", cwd: outputPath);
  await exec("composer require spatie/laravel-medialibrary", cwd: outputPath);
  await exec("composer require bugsnag/bugsnag-laravel", cwd: outputPath);

  await copySpecialFiles(specialFilesPath, outputPath);

  print('✅ Projeto Laravel "$name" criado com template Aastera.');
}

Future<void> copySpecialFiles(String sourceDir, String targetBaseDir) async {
  final sourceDirectory = Directory(sourceDir);

  if (!await sourceDirectory.exists()) return;

  final entities = await sourceDirectory.list(recursive: true).toList();

  for (final entity in entities) {
    if (entity is File) {
      final relativePath = p.relative(entity.path, from: sourceDir);
      final destinationPath = p.join(targetBaseDir, relativePath);

      final destinationFile = File(destinationPath);
      await destinationFile.parent.create(recursive: true);
      await entity.copy(destinationFile.path);
    }
  }
}
