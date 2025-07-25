import 'dart:io';
import 'package:path/path.dart' as p;

Future<void> copyTemplateFiles(
  String from,
  String to, {
  String? projectName,
}) async {
  final source = Directory(from);

  print(source);

  if (!await source.exists()) return;

  await for (FileSystemEntity entity in source.list(recursive: true)) {
    if (entity is File) {
      final relativePath = p.relative(entity.path, from: from);
      final newPath = p.join(to, relativePath);
      final newFile = File(newPath);

      await newFile.create(recursive: true);

      final content = await File(entity.path).readAsString();
      final replacedContent = content.replaceAll(
        '{{project_name}}',
        projectName ?? '',
      );
      await newFile.writeAsString(replacedContent);
    }
  }
}
