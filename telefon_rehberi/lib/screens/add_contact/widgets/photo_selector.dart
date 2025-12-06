import 'dart:io';
import 'package:flutter/material.dart';

class PhotoSelector extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const PhotoSelector({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
              image: imagePath != null
                  ? DecorationImage(
                      image: FileImage(File(imagePath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imagePath == null
                ? const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(height: 12),
          const Text(
            'Add Photo',
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
