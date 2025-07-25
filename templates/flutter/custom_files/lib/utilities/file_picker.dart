import 'dart:io';
import 'global.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> pickFile(
  BuildContext context, {
  required void Function(PlatformFile? file) callback,
}) async {
  final PlatformFile? file = await selectFile();

  if (file != null) {
    PlatformFile finalFile = file;
    callback(finalFile);
  }
}

Future<PlatformFile?> selectFile() async {
  try {
    final FilePickerResult? result = await _pickFile();
    if (result != null && result.files.isNotEmpty) {
      if (kIsWeb) {
        return result.files.first;
      } else {
        PlatformFile pickedFile = result.files.first;
        List<int> fileBytes = await _readFileBytes(pickedFile.path!);
        pickedFile = _createUpdatedFile(pickedFile, fileBytes);

        return pickedFile;
      }
    }
  } catch (e) {
    printOnDebug('Error selecting image: $e');
  }

  return null;
}

Future<FilePickerResult?> _pickFile() {
  return FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: false,
    onFileLoading: (FilePickerStatus status) => printOnDebug(status),
  );
}

Future<List<int>> _readFileBytes(String filePath) async {
  return await File(filePath).readAsBytes();
}

PlatformFile _createUpdatedFile(PlatformFile pickedFile, List<int> fileBytes) {
  return PlatformFile(
    name: pickedFile.name,
    size: pickedFile.size,
    path: pickedFile.path,
    bytes: Uint8List.fromList(fileBytes),
  );
}
