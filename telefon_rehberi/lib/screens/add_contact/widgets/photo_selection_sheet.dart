import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSelectionSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const PhotoSelectionSheet({super.key, required this.onImageSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCapsuleButton(
            context,
            title: 'Camera',
            icon: Icons.camera_alt_outlined,
            onTap: () => onImageSourceSelected(ImageSource.camera),
          ),
          const SizedBox(height: 8),
          _buildCapsuleButton(
            context,
            title: 'Gallery',
            icon: Icons.image_outlined,
            onTap: () => onImageSourceSelected(ImageSource.gallery),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCapsuleButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
          onTap();
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 1),
          shape: const StadiumBorder(),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
