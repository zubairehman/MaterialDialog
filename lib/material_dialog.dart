library material_dialog;

import 'package:flutter/material.dart';
import 'package:material_dialog/widgets/dialog.dart' as dialog;

class MaterialDialog extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final Widget content;
  final List<Widget> actions;
  final List<Widget> children;
  final Color headerColor;
  final Color backButtonColor;
  final Color closeButtonColor;
  final bool enableFullWidth;
  final bool enableFullHeight;
  final bool enableBackButton;
  final bool enableCloseButton;
  final double borderRadius;
  final VoidCallback onBackClick;
  final VoidCallback onCloseClick;

  const MaterialDialog({
    Key key,
    this.title,
    this.subTitle,
    this.content,
    this.actions,
    this.children,
    this.enableFullWidth = true,
    this.enableFullHeight = false,
    this.headerColor,
    this.backButtonColor = Colors.white,
    this.closeButtonColor = Colors.white,
    this.borderRadius = 10.0,
    this.onBackClick,
    this.onCloseClick,
    this.enableBackButton = false,
    this.enableCloseButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialog.SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      title: title ?? null,
      subTitle: subTitle ?? null,
      content: content,
      actions: actions,
      children: children,
      headerColor: headerColor,
      backButtonColor: backButtonColor,
      closeButtonColor: closeButtonColor,
      borderRadius: borderRadius,
      onBackClick: onBackClick,
      onCloseClick: onCloseClick,
      enableBackButton: enableBackButton,
      enableCloseButton: enableCloseButton,
      enableFullWidth: enableFullWidth,
      enableFullHeight: enableFullHeight,
    );
  }
}
