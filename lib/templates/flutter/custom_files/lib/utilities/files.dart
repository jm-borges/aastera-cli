// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../auxiliary/file_info.dart';
import '../config/config.dart';
import '../config/theme_data.dart';
import '../enums/file_picker_mode.dart';
import '../exceptions/known_exception.dart';
import '../lists/file_extensions.dart';
import '../maps/file_extensions.dart';
import '../providers/loading_indicator.dart';
import 'cache.dart';
import 'file_picker.dart';
import 'global.dart';
import 'image_picker.dart';
import 'snackbars.dart';

/// Handles the process of picking a file or image from the user's device.
///
/// This function provides a file picker dialog to select either an image or a file.
/// For non-web platforms, it offers a dialog allowing the user to specify the type of file
/// they want to upload. For web platforms, it defaults to picking a file.
/// If the selected file is an image, it can optionally be cropped.
///
/// The function manages loading indicators and handles known and unknown exceptions gracefully.
///
/// ### Parameters:
/// - [context]: The `BuildContext` required to manage the dialog and access app-level providers.
/// - [callback]: A function that will be called with the selected file (`PlatformFile?`).
///   If no file is selected, the callback will be invoked with `null`.
/// - [shouldCropImage]: (Optional) A `bool` flag that indicates whether the image should be cropped
///   after selection. Defaults to `true`.
///
/// ### Behavior:
/// - Displays a loading indicator during the file/image selection process.
/// - On non-web platforms, shows a dialog to choose between image or file upload.
/// - Handles known exceptions (`KnownException`) with a specific error message and logs unknown errors.
/// - Ensures the loading indicator is hidden when the operation completes, regardless of the outcome.
///
/// ### Exceptions:
/// - Catches and processes `KnownException` errors, displaying an appropriate error message to the user.
/// - Catches other exceptions, displaying a generic error message.
///
/// ### Example Usage:
/// ```dart
/// startFilePicker(
///   context: context,
///   callback: (PlatformFile? file) {
///     if (file != null) {
///       // Handle the selected file
///     } else {
///       // Handle the case where no file was selected
///     }
///   },
///   shouldCropImage: true,
/// );
/// ```
///
/// ### Dependencies:
/// - `LoadingIndicator`: A provider to control the loading state.
/// - `showFileDialog`: A method to show the dialog for file type selection.
/// - `pickImage` and `pickFile`: Methods to handle specific file/image selection.
/// - `showErrorSnackBar`: A method to show error messages in a snackbar.
Future<void> startFilePicker({
  required BuildContext context,
  required void Function(PlatformFile?) callback,
  bool shouldCropImage = true,
  FilePickerMode mode = FilePickerMode.both,
}) async {
  LoadingIndicator loadingIndicator = Provider.of<LoadingIndicator>(
    context,
    listen: false,
  );

  try {
    loadingIndicator.show();

    if (mode == FilePickerMode.imageOnly) {
      await pickImage(context, callback, shouldCropImage: shouldCropImage);
      return;
    }

    if (mode == FilePickerMode.fileOnly || kIsWeb) {
      await pickFile(context, callback: callback);
      return;
    }

    if (!kIsWeb) {
      String? result = await showFileDialog(context);

      if (result != null && result == "image") {
        pickImage(context, callback, shouldCropImage: shouldCropImage);
      } else if (result != null && result == "file") {
        pickFile(context, callback: callback);
      }
    } else {
      pickFile(context, callback: callback);
    }
  } on KnownException catch (e, stackTrace) {
    treatException(e, stackTrace);
    showErrorSnackBar(context, e.toString());
  } catch (e, stackTrace) {
    treatException(e as Exception, stackTrace);
    showErrorSnackBar(
      context,
      'An error occurred while performing this action.',
    );
  } finally {
    loadingIndicator.hide();
  }
}

Future<MultipartFile> createMultipartFile(PlatformFile file) async {
  final String fileExtension = file.extension!.toLowerCase();

  final String? mediaType = mediaTypeMap[fileExtension];
  if (mediaType == null) {
    throw Exception('Esse formato de arquivo não é suportado: $fileExtension.');
  }

  if (['jpg', 'jpeg', 'jfif', 'jpe', 'jif', 'png'].contains(fileExtension)) {
    return compressImageFile(file);
  } else {
    return MultipartFile.fromBytes(
      file.bytes!,
      filename: file.name,
      contentType: MediaType.parse(mediaType),
    );
  }
}

Future<MultipartFile> compressImageFile(PlatformFile file) async {
  try {
    final Uint8List compressedBytes = await _compressToWebP(file.bytes!);
    return _createMultipartFile(compressedBytes, file.name);
  } catch (e) {
    _handleCompressionError(e);
    throw Exception("Erro ao processar a imagem para WebP.");
  }
}

Future<Uint8List> _compressToWebP(Uint8List imageBytes) async {
  return await FlutterImageCompress.compressWithList(
    imageBytes,
    quality: 80,
    format: CompressFormat.webp,
  );
}

MultipartFile _createMultipartFile(Uint8List bytes, String originalFileName) {
  final String webPFileName = '${originalFileName.split('.').first}.webp';
  return MultipartFile.fromBytes(
    bytes,
    filename: webPFileName,
    contentType: MediaType('image', 'webp'),
  );
}

void _handleCompressionError(dynamic error) {
  printOnDebug(error);
}

Future<String?> showFileDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: themeData.primaryColor,
        content: const Text("Selecionar dos documentos ou imagem?"),
        actions: [
          _buildSelectImageFileButton(context),
          _buildSelectDocumentFileButton(context),
        ],
      );
    },
  );
}

Widget _buildSelectFileButton(
  BuildContext context,
  String label,
  String returnValue,
) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context, returnValue);
    },
    child: Text(label, style: TextStyle(color: Colors.white)),
  );
}

Widget _buildSelectImageFileButton(BuildContext context) {
  return _buildSelectFileButton(context, "Imagem", "image");
}

Widget _buildSelectDocumentFileButton(BuildContext context) {
  return _buildSelectFileButton(context, "Documentos", "file");
}

String adjustGalleryFileUrl(String originalUrl) {
  String url = originalUrl.replaceFirst('storage/', '');
  Uri uri = Uri.parse(url);
  String path = uri.path.substring(1);
  printOnDebug('${Config.storageUrl}/$path');
  return '${Config.storageUrl}/$path';
}

Future<Map<String, dynamic>> getFile(FileInfo fileData) async {
  try {
    final List<int> bytes = await getImageBytes(
      adjustGalleryFileUrl(fileData.originalUrl!),
    );

    return {
      'name': fileData.fileName,
      'bytes': Uint8List.fromList(bytes),
      'size': bytes.length,
    };
  } catch (e) {
    printOnDebug('Erro ao carregar imagem: $e');
    return {'name': fileData.fileName, 'bytes': Uint8List(0), 'size': 0};
  }
}

Future<List<int>> getImageBytes(String imageUrl) async {
  CustomImageCache cache = CustomImageCache();
  List<int>? cachedBytes = await cache.getImageFromCache(imageUrl);
  if (cachedBytes != null) {
    printOnDebug('Imagem carregada do cache');
    return cachedBytes;
  }

  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    final List<int> imageBytes = response.bodyBytes;

    await cache.saveImageToCache(imageUrl, imageBytes);

    return imageBytes;
  } else if (response.statusCode == 404) {
    printOnDebug('Image not found');
    throw Exception('Image not found');
  } else {
    printOnDebug(response.statusCode);
    throw Exception('Failed to load image');
  }
}

Future<Uint8List> getLogoBytes() async {
  return await getBytesFromAssetFile('assets/images/oficina_flow_logo.jpg');
}

Future<Uint8List> getBytesFromAssetFile(String path) async {
  return (await rootBundle.load(path)).buffer.asUint8List();
}

PlatformFile generatePlatformFileFromBytes(String fileName, Uint8List bytes) {
  return PlatformFile.fromMap({
    'name': fileName,
    'bytes': bytes,
    'size': bytes.length,
  });
}

bool hasImageExtension(String? fileUrl, {bool parseAsUrl = false}) {
  if (fileUrl == null) return false;

  String filePath = parseAsUrl ? Uri.parse(fileUrl).path : fileUrl;

  return imageExtensions.any((extension) => filePath.endsWith(extension));
}

String? getFileExtension(String? fileUrl, {bool parseAsUrl = false}) {
  if (fileUrl == null) return null;

  String filePath = parseAsUrl ? Uri.parse(fileUrl).path : fileUrl;

  for (String extension in fileExtensions) {
    if (filePath.toLowerCase().endsWith(extension)) {
      return extension;
    }
  }

  return null;
}

Future<PlatformFile?> loadFile(FileInfo? fileData) async {
  if (fileData != null) {
    try {
      Map<String, dynamic> image = await getFile(fileData);

      return PlatformFile.fromMap(image);
    } catch (e) {
      printOnDebug(e);
      rethrow;
    }
  }

  return null;
}
