import 'package:flutter/material.dart';
import '../widgets/delete_confirmation_sheet.dart';

class DialogUtils {
  static Future<void> showDeleteConfirmationSheet({
    required BuildContext context,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DeleteConfirmationSheet(
        onConfirm: () {
          Navigator.pop(context);
          onConfirm();
        },
        onCancel: () {
          Navigator.pop(context);
          onCancel?.call();
        },
      ),
    );
  }
}
