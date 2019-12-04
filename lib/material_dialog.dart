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
  final Color backgroundColor;
  final bool enableFullWidth;
  final bool enableFullHeight;
  final bool enableBackButton;
  final bool enableCloseButton;
  final double borderRadius;
  final VoidCallback onBackButtonClicked;
  final VoidCallback onCloseButtonClicked;

  const MaterialDialog({
    Key key,
    this.title,
    this.subTitle,
    this.content,
    this.actions,
    this.children,
    this.enableFullWidth = false,
    this.enableFullHeight = false,
    this.headerColor,
    this.backButtonColor = Colors.black,
    this.closeButtonColor = Colors.black,
    this.borderRadius = 10.0,
    this.onBackButtonClicked,
    this.onCloseButtonClicked,
    this.enableBackButton = false,
    this.enableCloseButton = false,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialog.SimpleDialog(
      backgroundColor: backgroundColor,
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
      onBackClick: onBackButtonClicked,
      onCloseClick: onCloseButtonClicked,
      enableBackButton: enableBackButton,
      enableCloseButton: enableCloseButton,
      enableFullWidth: enableFullWidth,
      enableFullHeight: enableFullHeight,
    );
  }
}
