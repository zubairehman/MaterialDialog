library material_dialog;

import 'package:flutter/material.dart';
import 'package:material_dialog/widgets/dialog.dart' as dialog;

class MaterialDialog extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final Widget content;
  final List<Widget> actions;
  final List<Widget> children;
  final bool enableFullWidth;
  final bool enableFullHeight;

  const MaterialDialog({
    Key key,
    this.title,
    this.subTitle,
    this.content,
    this.actions,
    this.children,
    this.enableFullWidth = true,
    this.enableFullHeight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialog.SimpleDialog(
      title: title ?? null,
      subTitle: subTitle ?? null,
      content: content,
      actions: actions,
      children: children,
      enableFullWidth: enableFullWidth,
      enableFullHeight: enableFullHeight,
    );
  }
}
