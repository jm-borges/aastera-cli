import 'dart:io';
import 'package:process_run/process_run.dart';

Future<void> exec(String command, {String? cwd}) async {
  try {
    await run(command, workingDirectory: cwd, verbose: true);
  } catch (e) {
    print('❌ Erro ao executar "$command": $e');
    exit(1);
  }
}
