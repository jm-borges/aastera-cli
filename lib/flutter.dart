import 'package:path/path.dart' as p;
import 'dart:io';
import '../utils/file_utils.dart';
import '../utils/exec.dart';

Future<void> initFlutterProject(String name) async {
  final templatePath = p.join(
    Directory.current.path,
    'templates',
    'flutter',
    'custom_files',
  );
  final outputPath = p.join(Directory.current.path, name);

  print('🔧 Creating Flutter project "$name"...');

  await exec('flutter create $name');
  await copyTemplateFiles(templatePath, outputPath, projectName: name);
  await _replaceTestFolderWithEmpty(outputPath);
  await exec('flutter pub get', cwd: outputPath);

  // Run the environment update script if it exists
  final script = Platform.isWindows ? 'update_env.bat' : 'update_env.sh';
  final command = Platform.isWindows ? script : 'bash $script';
  final scriptPath = p.join(outputPath, script);

  if (await File(scriptPath).exists()) {
    print('📜 Executing environment setup script: $script');
    await exec(command, cwd: outputPath);
  } else {
    print('⚠️ Script $script not found in $outputPath');
  }

  print('✅ Flutter project "$name" created with the Aastera template.');

  // Final reminder about Firebase setup
  print(
    '👋 Don\'t forget to link a Firebase project to this app for full functionality.',
  );
  print(
    '🔧 We recommend installing and using the FlutterFire CLI to streamline this process:',
  );
  print('    dart pub global activate flutterfire_cli');
  print('    flutterfire configure');
}

Future<void> _replaceTestFolderWithEmpty(String outputPath) async {
  final testDir = Directory(p.join(outputPath, 'test'));

  if (await testDir.exists()) {
    await testDir.delete(recursive: true);
  }

  await testDir.create();
}
