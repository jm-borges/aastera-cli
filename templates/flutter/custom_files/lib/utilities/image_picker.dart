import 'dart:typed_data';
import 'global.dart';
import '../views/common/custom_image_source_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(
  BuildContext context,
  void Function(PlatformFile? image) callback, {
  bool shouldCropImage = true,
}) async {
  PlatformFile? image = await selectImageFile(context);
  if (image != null && shouldCropImage) {
    image = await _cropImage(image);
    callback(image);
  } else {
    callback(image);
  }
}

Future<PlatformFile?> selectImageFile(BuildContext context) async {
  try {
    final XFile? pickedFile = await _pickImageFile(context);

    if (pickedFile != null) {
      final PlatformFile updatedFile = await _convertToPlatformFile(pickedFile);

      return updatedFile;
    }
  } catch (e) {
    printOnDebug('Error selecting image: $e');
  }

  return null;
}

Future<XFile?> _pickImageFile(BuildContext context) async {
  try {
    final ImageSource? source = await _showImageSourceDialog(context);
    if (source != null) {
      final XFile? pickedFile = await _pickImageFromSource(source);
      return pickedFile;
    }
  } catch (e) {
    printOnDebug('Error picking image: $e');
  }
  return null;
}

Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
  return await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return const CustomImageSourceDialog();
    },
  );
}

Future<XFile?> _pickImageFromSource(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: source);
  return pickedFile;
}

List<CropAspectRatioPresetData> _getCropImageAspectRatioPresets() {
  return [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ];
}

AndroidUiSettings _buildAndroidUiCropImageSettings() {
  return AndroidUiSettings(
    toolbarTitle: 'Cortar imagem',
    toolbarColor: Colors.blue,
    toolbarWidgetColor: Colors.white,
    initAspectRatio: CropAspectRatioPreset.original,
    lockAspectRatio: false,
    cropStyle: CropStyle.rectangle,
    aspectRatioPresets: _getCropImageAspectRatioPresets(),
  );
}

IOSUiSettings _buildIOSUiCropImageSettings() {
  return IOSUiSettings(
    title: 'Cortar imagem',
    cropStyle: CropStyle.rectangle,
    aspectRatioPresets: _getCropImageAspectRatioPresets(),
  );
}

List<PlatformUiSettings> _getImageCropperUiSettings() {
  return [_buildAndroidUiCropImageSettings(), _buildIOSUiCropImageSettings()];
}

Future<PlatformFile?> _cropImage(PlatformFile image) async {
  final imageCropper = ImageCropper();

  CroppedFile? croppedFile = await imageCropper.cropImage(
    sourcePath: image.path!,
    uiSettings: _getImageCropperUiSettings(),
  );

  if (croppedFile != null) {
    final List<int> fileBytes = await croppedFile.readAsBytes();
    return _createUpdatedFile(image, fileBytes);
  }

  return null;
}

PlatformFile _createUpdatedFile(PlatformFile pickedFile, List<int> fileBytes) {
  return PlatformFile(
    name: pickedFile.name,
    size: pickedFile.size,
    path: pickedFile.path,
    bytes: Uint8List.fromList(fileBytes),
  );
}

Future<PlatformFile> _convertToPlatformFile(XFile pickedFile) async {
  final Uint8List bytes = await pickedFile.readAsBytes();

  return PlatformFile(
    name: pickedFile.name,
    size: bytes.length,
    path: pickedFile.path,
    bytes: bytes,
  );
}
