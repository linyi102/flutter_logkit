import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logkit/utils/snackbar.dart';

class ClipboardUtil {
  static copy({required BuildContext context, required String text}) async {
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) showSnackBar(context, '复制成功');
  }
}
