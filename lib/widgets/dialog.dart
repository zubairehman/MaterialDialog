// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_dialog/widgets/button_bar.dart' as buttonBar;

// Examples can assume:
// enum Department { treasury, state }
// BuildContext context;

/// A material design dialog.
///
/// This dialog widget does not have any opinion about the contents of the
/// dialog. Rather than using this widget directly, consider using [AlertDialog]
/// or [SimpleDialog], which implement specific kinds of material design
/// dialogs.
///
/// See also:
///
///  * [AlertDialog], for dialogs that have a message and some buttons.
///  * [SimpleDialog], for dialogs that offer a variety of options.
///  * [showDialog], which actually displays the dialog and returns its result.
///  * <https://material.io/design/components/dialogs.html>
class Dialog extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const Dialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
    this.child,
  }) : super(key: key);

  /// {@template flutter.material.dialog.backgroundColor}
  /// The background color of the surface of this [Dialog].
  ///
  /// This sets the [Material.color] on this [Dialog]'s [Material].
  ///
  /// If `null`, [ThemeData.cardColor] is used.
  /// {@endtemplate}
  final Color backgroundColor;

  /// {@template flutter.material.dialog.elevation}
  /// The z-coordinate of this [Dialog].
  ///
  /// If null then [DialogTheme.elevation] is used, and if that's null then the
  /// dialog's elevation is 24.0.
  /// {@endtemplate}
  /// {@macro flutter.material.material.elevation}
  final double elevation;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder shape;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: Material(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation:
                  elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// An option used in a [SimpleDialog].
///
/// A simple dialog offers the user a choice between several options. This
/// widget is commonly used to represent each of the options. If the user
/// selects this option, the widget will call the [onPressed] callback, which
/// typically uses [Navigator.pop] to close the dialog.
///
/// The padding on a [SimpleDialogOption] is configured to combine with the
/// default [SimpleDialog.contentPadding] so that each option ends up 8 pixels
/// from the other vertically, with 20 pixels of spacing between the dialog's
/// title and the first option, and 24 pixels of spacing between the last option
/// and the bottom of the dialog.
///
/// {@tool sample}
///
/// ```dart
/// SimpleDialogOption(
///   onPressed: () { Navigator.pop(context, Department.treasury); },
///   child: const Text('Treasury department'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [SimpleDialog], for a dialog in which to use this widget.
///  * [showDialog], which actually displays the dialog and returns its result.
///  * [FlatButton], which are commonly used as actions in other kinds of
///    dialogs, such as [AlertDialog]s.
///  * <https://material.io/design/components/dialogs.html#simple-dialog>
class SimpleDialogOption extends StatelessWidget {
  /// Creates an option for a [SimpleDialog].
  const SimpleDialogOption({
    Key key,
    this.onPressed,
    this.child,
  }) : super(key: key);

  /// The callback that is called when this option is selected.
  ///
  /// If this is set to null, the option cannot be selected.
  ///
  /// When used in a [SimpleDialog], this will typically call [Navigator.pop]
  /// with a value for [showDialog] to complete its future with.
  final VoidCallback onPressed;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: child,
      ),
    );
  }
}

/// A simple material design dialog.
///
/// A simple dialog offers the user a choice between several options. A simple
/// dialog has an optional title that is displayed above the choices.
///
/// Choices are normally represented using [SimpleDialogOption] widgets. If
/// other widgets are used, see [contentPadding] for notes regarding the
/// conventions for obtaining the spacing expected by Material Design.
///
/// For dialogs that inform the user about a situation, consider using an
/// [AlertDialog].
///
/// Typically passed as the child widget to [showDialog], which displays the
/// dialog.
///
/// {@tool sample}
///
/// In this example, the user is asked to select between two options. These
/// options are represented as an enum. The [showDialog] method here returns
/// a [Future] that completes to a value of that enum. If the user cancels
/// the dialog (e.g. by hitting the back button on Android, or tapping on the
/// mask behind the dialog) then the future completes with the null value.
///
/// The return value in this example is used as the index for a switch statement.
/// One advantage of using an enum as the return value and then using that to
/// drive a switch statement is that the analyzer will flag any switch statement
/// that doesn't mention every value in the enum.
///
/// ```dart
/// Future<void> _askedToLead() async {
///   switch (await showDialog<Department>(
///     context: context,
///     builder: (BuildContext context) {
///       return SimpleDialog(
///         title: const Text('Select assignment'),
///         children: <Widget>[
///           SimpleDialogOption(
///             onPressed: () { Navigator.pop(context, Department.treasury); },
///             child: const Text('Treasury department'),
///           ),
///           SimpleDialogOption(
///             onPressed: () { Navigator.pop(context, Department.state); },
///             child: const Text('State department'),
///           ),
///         ],
///       );
///     }
///   )) {
///     case Department.treasury:
///       // Let's go.
///       // ...
///     break;
///     case Department.state:
///       // ...
///     break;
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [SimpleDialogOption], which are options used in this type of dialog.
///  * [AlertDialog], for dialogs that have a row of buttons below the body.
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * [showDialog], which actually displays the dialog and returns its result.
///  * <https://material.io/design/components/dialogs.html#simple-dialog>
class SimpleDialog extends StatelessWidget {
  /// Creates a simple dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [titlePadding] and [contentPadding] arguments must not be null.
  const SimpleDialog({
    Key key,
    this.title,
    this.subTitle,
    this.titlePadding = const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
    this.children,
    this.contentPadding = const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.content,
    this.contentTextStyle,
    this.actions,
    this.enableFullWidth,
    this.enableFullHeight,
    this.headerColor,
    this.backButtonColor,
    this.closeButtonColor,
    this.borderRadius,
    this.onBackClick,
    this.onCloseClick,
    this.enableBackButton,
    this.enableCloseButton,
  })  : assert(titlePadding != null),
        assert(contentPadding != null),
        super(key: key);

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// The (optional) subtitle of the dialog is displayed below title
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget subTitle;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided.
  ///
  /// By default, this provides the recommend Material Design padding of 24
  /// pixels around the left, top, and right edges of the title.
  ///
  /// See [contentPadding] for the conventions regarding padding between the
  /// [title] and the [children].
  final EdgeInsetsGeometry titlePadding;

  /// The (optional) content of the dialog is displayed in a
  /// [SingleChildScrollView] underneath the title.
  ///
  /// Typically a list of [SimpleDialogOption]s.
  final List<Widget> children;

  /// Padding around the content.
  ///
  /// By default, this is 12 pixels on the top and 16 pixels on the bottom. This
  /// is intended to be combined with children that have 24 pixels of padding on
  /// the left and right, and 8 pixels of padding on the top and bottom, so that
  /// the content ends up being indented 20 pixels from the title, 24 pixels
  /// from the bottom, and 24 pixels from the sides.
  ///
  /// The [SimpleDialogOption] widget uses such padding.
  ///
  /// If there is no [title], the [contentPadding] should be adjusted so that
  /// the top padding ends up being 24 pixels.
  final EdgeInsetsGeometry contentPadding;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog in a lighter font.
  ///
  /// Typically this is a [SingleChildScrollView] that contains the dialog's
  /// message. As noted in the [AlertDialog] documentation, it's important
  /// to use a [SingleChildScrollView] if there's any risk that the content
  /// will not fit.
  final Widget content;

  /// Style for the text in the [content] of this [AlertDialog].
  ///
  /// If null, [DialogTheme.contentTextStyle] is used, if that's null, defaults
  /// to [ThemeData.textTheme.subhead].
  final TextStyle contentTextStyle;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  ///
  /// Typically this is a list of [FlatButton] widgets.
  ///
  /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
  /// of padding on each side.
  ///
  /// If the [title] is not null but the [content] _is_ null, then an extra 20
  /// pixels of padding is added above the [ButtonBar] to separate the [title]
  /// from the [actions].
  final List<Widget> actions;

  /// {@macro flutter.material.dialog.backgroundColor}
  final Color backgroundColor;

  /// {@macro flutter.material.dialog.elevation}
  /// {@macro flutter.material.material.elevation}
  final double elevation;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be inferred from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.dialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String semanticLabel;

  /// {@macro flutter.material.dialog.shape}
  final ShapeBorder shape;

  final enableFullWidth;
  final enableFullHeight;
  final Color headerColor;
  final Color backButtonColor;
  final Color closeButtonColor;
  final double borderRadius;
  final VoidCallback onBackClick;
  final VoidCallback onCloseClick;
  final bool enableBackButton;
  final bool enableCloseButton;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final List<Widget> body = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      body.add(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              topLeft: Radius.circular(borderRadius),
            ),
          ),
          child: Row(
            children: <Widget>[
              enableBackButton
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: backButtonColor,
                      ),
                      onPressed: onBackClick,
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: Padding(
                  padding: enableBackButton
                      ? EdgeInsets.all(12.0)
                      : EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DefaultTextStyle(
                        style: theme.textTheme.title,
                        child: Semantics(namesRoute: true, child: title),
                      ),
//                      SizedBox(height: 4.0),
                      subTitle != null
                          ? DefaultTextStyle(
                              style: contentTextStyle ??
                                  dialogTheme.contentTextStyle ??
                                  theme.textTheme.subhead,
                              child: subTitle,
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              enableCloseButton
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: closeButtonColor,
                      ),
                      onPressed: onCloseClick,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      );
    } else {
      switch (theme.platform) {
        case TargetPlatform.iOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label =
              semanticLabel ?? MaterialLocalizations.of(context)?.dialogLabel;
      }
    }

    if (content != null) {
      body.add(
        Flexible(
          child: Padding(
            padding: title == null
                ? EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0)
                : children == null
                    ? EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0)
                    : EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: DefaultTextStyle(
              style: contentTextStyle ??
                  dialogTheme.contentTextStyle ??
                  theme.textTheme.subhead,
              child: content,
            ),
          ),
        ),
      );
    }

    if (children != null) {
      body.add(
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            padding: contentPadding,
            child: ListBody(children: children),
          ),
        ),
      );
    }

    if (actions != null) {
      body.add(
        Column(
          children: <Widget>[
            Divider(height: 1.0),
            (enableFullWidth &&
                        MediaQuery.of(context).orientation !=
                            Orientation.portrait) ||
                    actions.length < 3
                ? buttonBar.ButtonBar(
                    children: actions,
                  )
                : FittedBox(
                    child: buttonBar.ButtonBar(
                      children: actions,
                    ),
                  ),
          ],
        ),
      );
    }

    Widget dialogChild = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth:
                enableFullWidth ? MediaQuery.of(context).size.width : 280.0,
            minHeight: enableFullHeight &&
                    MediaQuery.of(context).orientation != Orientation.portrait
                ? MediaQuery.of(context).size.height
                : 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: body,
        ),
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      child: dialogChild,
    );
  }
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

/// Displays a Material dialog above the current contents of the app, with
/// Material entrance and exit animations, modal barrier color, and modal
/// barrier behavior (dialog is dismissible with a tap on the barrier).
///
/// This function takes a `builder` which typically builds a [Dialog] widget.
/// Content below the dialog is dimmed with a [ModalBarrier]. The widget
/// returned by the `builder` does not share a context with the location that
/// `showDialog` is originally called from. Use a [StatefulBuilder] or a
/// custom [StatefulWidget] if the dialog needs to update dynamically.
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the dialog. It is only used when the method is called. Its corresponding
/// widget can be safely removed from the tree before the dialog is closed.
///
/// The `child` argument is deprecated, and should be replaced with `builder`.
///
/// Returns a [Future] that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the dialog was closed.
///
/// The dialog route created by this method is pushed to the root navigator.
/// If the application has multiple [Navigator] objects, it may be necessary to
/// call `Navigator.of(context, rootNavigator: true).pop(result)` to close the
/// dialog rather than just `Navigator.pop(context, result)`.
///
/// See also:
///
///  * [AlertDialog], for dialogs that have a row of buttons below a body.
///  * [SimpleDialog], which handles the scrolling of the contents and does
///    not show buttons below its body.
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * [showCupertinoDialog], which displays an iOS-style dialog.
///  * [showGeneralDialog], which allows for customization of the dialog popup.
///  * <https://material.io/design/components/dialogs.html>
Future<T> showDialog<T>({
  @required
      BuildContext context,
  bool barrierDismissible = true,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog.')
      Widget child,
  WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}
