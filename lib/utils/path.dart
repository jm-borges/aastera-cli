import 'dart:isolate';
import 'package:path/path.dart' as p;

/// Retorna o caminho absoluto para a subpasta de templates
Future<String> getTemplatePath(String subfolder) async {
  final uri = await Isolate.resolvePackageUri(
    Uri.parse('package:aastera/cli.dart'),
  );
  if (uri == null) {
    throw Exception('Não foi possível resolver o caminho do pacote.');
  }

  final libDir = p.dirname(uri.toFilePath()); // caminho até lib/
  return p.join(
    libDir,
    'templates',
    subfolder,
  ); // ex: lib/templates/flutter/custom_files
}
