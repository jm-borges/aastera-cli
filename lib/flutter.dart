import 'package:path/path.dart' as p;
import 'dart:io';
import '../utils/file_utils.dart';
import '../utils/exec.dart';
import '../utils/path.dart';

Future<void> initFlutterProject(String name) async {
  final outputPath = p.join(Directory.current.path, name);
  final templatePath = await getTemplatePath('flutter/custom_files');

  print('🔧 Creating Flutter project "$name"...');

  await _createFlutterProject(name);
  await _applyCustomTemplate(templatePath, outputPath, name);
  await _replaceTestFolderWithEmpty(outputPath);
  await _installDependencies(outputPath);
  await _runEnvScriptIfExists(outputPath);

  _printFinalInstructions(name);
}

Future<void> _createFlutterProject(String name) async {
  await exec('flutter create $name');
}

Future<void> _applyCustomTemplate(
  String templatePath,
  String outputPath,
  String projectName,
) async {
  await copyTemplateFiles(templatePath, outputPath, projectName: projectName);
}

Future<void> _replaceTestFolderWithEmpty(String outputPath) async {
  final testDir = Directory(p.join(outputPath, 'test'));
  if (await testDir.exists()) await testDir.delete(recursive: true);
  await testDir.create();
}

Future<void> _installDependencies(String outputPath) async {
  await exec('flutter pub get', cwd: outputPath);
}

Future<void> _runEnvScriptIfExists(String outputPath) async {
  final script = Platform.isWindows ? 'update_env.bat' : 'update_env.sh';
  final command = Platform.isWindows ? script : 'bash $script';
  final scriptPath = p.join(outputPath, script);

  if (await File(scriptPath).exists()) {
    print('📜 Executing environment setup script: $script');
    await exec(command, cwd: outputPath);
  } else {
    print('⚠️ Script $script not found in $outputPath');
  }
}

void _printFinalInstructions(String projectName) {
  print(
    '✅ Flutter project "$projectName" created with the Aastera template.\n',
  );

  print('📋 Next Steps (Checklist):');

  print('''
  🔗  Firebase Configuration:
      ▫️ Install FlutterFire CLI:
         dart pub global activate flutterfire_cli

      ▫️ Configure Firebase:
         flutterfire configure
          
      ▫️ Move the firebase_options file:
         Move the file generated to the folder lib/config/firebase

  🧱  App Identity:
      📦  Install `rename` package if needed:
         flutter pub global activate rename

      ▫️ Rename project/package:
         rename setAppName --targets ios,android,web,windows,linux --value "YourAppName"

      ▫️ Rename bundleId:
         rename setBundleId --targets ios,android,web,windows,linux --value "com.example.app"

  🖼️  Branding:
      ▫️ Configure app icon:
         set the image and colors in the pubspec.yaml file
         dart run flutter_launcher_icons

      ▫️ Configure splash screen:
         set the image and colors in the pubspec.yaml file
         dart run flutter_native_splash:create
  ''');

  print('🚀 Your project is ready! Happy coding 💙');
}
