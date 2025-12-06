import 'package:flutter/material.dart';

class AddContactHeader extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool canSave;

  const AddContactHeader({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.canSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 36, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onCancel,
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF007AFF),
                fontSize: 17,
              ),
            ),
          ),
          const Text(
            'New Contact',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          GestureDetector(
            onTap: canSave ? onSave : null,
            child: Text(
              'Done',
              style: TextStyle(
                color: canSave ? const Color(0xFF007AFF) : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
