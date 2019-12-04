import 'package:example/ui/demo/dialog_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_dialog/material_dialog.dart';

class DialogDemo extends StatefulWidget {
  @override
  DialogDemoState createState() => DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  // global key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // title
  final String _alertTitle = 'Discard draft?';

  // message
  final String _alertText =
      'Let Google help apps determine location. This means sending anonymous location '
      'data to Google, even when no apps are running.';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Custom Material Dialogs'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 72.0),
        children: <Widget>[
          RaisedButton(
            child: const Text('ALERT'),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                context: context,
                child: _buildAlertDialog(theme, context),
              );
            },
          ),
          RaisedButton(
            child: const Text('ALERT WITH TITLE'),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                context: context,
                child: _buildAlertDialogWithTitle(theme, context),
              );
            },
          ),
          RaisedButton(
            child: const Text(
              'ALERT WITH CLOSE AND BACK BUTTON',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                context: context,
                child: _buildAlertDialogWithCloseAndBackButton(theme, context),
              );
            },
          ),
          RaisedButton(
            child: const Text('ALERT WITH CHILDREN'),
            onPressed: () {
              showDemoDialog<String>(
                context: context,
                child: _buildAlertDialogWithChildren(theme, context, false),
              );
            },
          ),
          RaisedButton(
            child: const Text('FULLSCREEN'),
            onPressed: () {
              showDemoDialog<String>(
                context: context,
                child: _buildAlertDialogWithChildren(theme, context, true),
              );
            },
          ),
        ]
            // Add a little space between the buttons
            .map<Widget>((Widget button) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: button,
          );
        }).toList(),
      ),
    );
  }

  // Example 1: Basic Alert Dialog ---------------------------------------------
  Widget _buildAlertDialog(ThemeData theme, BuildContext context) {
    return MaterialDialog(
      content: Text(_alertText),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.agree);
          },
        ),
        FlatButton(
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.cancel);
          },
        ),
      ],
    );
  }

  // Example 2: Basic Alert Dialog And Title -----------------------------------
  Widget _buildAlertDialogWithTitle(ThemeData theme, BuildContext context) {
    return MaterialDialog(
      title: Text(_alertTitle),
      subTitle: Text('Subtitle'),
      content: Text(_alertText),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.agree);
          },
        ),
        FlatButton(
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.cancel);
          },
        ),
      ],
    );
  }

  // Example 3: Basic Alert Dialog With Close & Back Buttons -------------------
  Widget _buildAlertDialogWithCloseAndBackButton(
      ThemeData theme, BuildContext context) {
    return MaterialDialog(
      title: Text(_alertTitle),
      subTitle: Text('Subtitle'),
      content: Text(_alertText),
      enableBackButton: true,
      enableCloseButton: true,
      onBackButtonClicked: () {
        Navigator.pop(context, DialogDemoAction.agree);
      },
      onCloseButtonClicked: () {
        Navigator.pop(context, DialogDemoAction.cancel);
      },
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.agree);
          },
        ),
        FlatButton(
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.cancel);
          },
        ),
      ],
    );
  }

  // Example 4: Basic Alert Dialog With Children -------------------------------
  Widget _buildAlertDialogWithChildren(
      ThemeData theme, BuildContext context, bool isFullScreen) {
    return MaterialDialog(
      borderRadius: 8.0,
      enableFullHeight: isFullScreen,
      enableFullWidth: isFullScreen,
      enableCloseButton: true,
      closeButtonColor: Colors.white,
      headerColor: Theme.of(context).primaryColor,
      title: Text(
        _alertTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      subTitle: Text(
        'Subtitle',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12.0,
        ),
      ),
      onCloseButtonClicked: () {
        Navigator.pop(context, DialogDemoAction.cancel.toString());
      },
      children: <Widget>[
        Text(
          _alertTitle,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          _alertText,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          decoration: InputDecoration(hintText: 'Enter Username'),
        ),
      ],
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.cancel.toString());
          },
        ),
        FlatButton(
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.button.copyWith(
                fontSize: 12.0, color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context, DialogDemoAction.agree.toString());
          },
        )
      ],
    );
  }

  // general methods:-----------------------------------------------------------
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('You selected: $value'),
        ));
      }
    });
  }
}
