import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageSourceDialog extends StatelessWidget {
  const CustomImageSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageSourceButton(
              context, 'Imagem da galeria', Icons.image, ImageSource.gallery),
          const SizedBox(height: 16.0),
          _buildImageSourceButton(
              context, 'Usar câmera', Icons.camera_alt, ImageSource.camera),
        ],
      ),
    );
  }

  Widget _buildImageSourceButton(
      BuildContext context, String text, IconData icon, ImageSource source) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(source),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
                fontSize: 16.0, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
