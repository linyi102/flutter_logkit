import 'package:flutter/material.dart';

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    clipBehavior: Clip.antiAlias,
    builder: builder,
  );
}
