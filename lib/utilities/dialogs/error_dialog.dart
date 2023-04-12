import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error ocurred',
    content: text,
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
