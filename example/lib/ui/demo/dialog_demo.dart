import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

const String _alertWithoutTitleText = 'Discard draft?';

const String _alertWithTitleText =
    'Let Google help apps determine location. This means sending anonymous location '
    'data to Google, even when no apps are running.';

class DialogDemoItem extends StatelessWidget {
  const DialogDemoItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class DialogDemo extends StatefulWidget {
  static const String routeName = '/material/dialog';

  @override
  DialogDemoState createState() => DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _selectedTime = TimeOfDay(hour: now.hour, minute: now.minute);
  }

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Dialogs'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 72.0),
        children: <Widget>[
          RaisedButton(
            child: const Text('ALERT'),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                context: context,
                child: MaterialDialog(
                  title: Text('Dialog Title'),
                  subTitle: Text('Dialog Subtitle'),
                  content: Column(
                    children: <Widget>[
                      DialogDemoItem(
                        icon: Icons.account_circle,
                        color: theme.primaryColor,
                        text: 'username@gmail.com',
                        onPressed: () {
                          Navigator.pop(context, 'username@gmail.com');
                        },
                      ),
                      DialogDemoItem(
                        icon: Icons.account_circle,
                        color: theme.primaryColor,
                        text: 'user02@gmail.com',
                        onPressed: () {
                          Navigator.pop(context, 'user02@gmail.com');
                        },
                      ),
                      DialogDemoItem(
                        icon: Icons.add_circle,
                        text: 'add account',
                        color: theme.disabledColor,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Wrap(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.cancel);
                          },
                        ),
                        FlatButton(
                          child: const Text('DISCARD'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                        ),
                        FlatButton(
                          child: const Text('DISCARD'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          RaisedButton(
            child: const Text('ALERT WITH TITLE'),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                context: context,
                child: AlertDialog(
                  title: const Text('Use Google\'s location service?'),
                  content: Text(
                    _alertWithTitleText,
                    style: dialogTextStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('DISAGREE'),
                      onPressed: () {
                        Navigator.pop(context, DialogDemoAction.disagree);
                      },
                    ),
                    FlatButton(
                      child: const Text('AGREE'),
                      onPressed: () {
                        Navigator.pop(context, DialogDemoAction.agree);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          RaisedButton(
            child: const Text('SIMPLE'),
            onPressed: () {
              showDemoDialog<String>(
                context: context,
                child: MaterialDialog(
                  borderRadius: 5.0,
                  headerColor: Theme.of(context).primaryColor,
                  enableBackButton: false,
                  enableCloseButton: true,
                  title: Text(
                    'Title goes here',
                    style: TextStyle(color: Colors.white),
                  ),
                  subTitle: Text(
                    'Subtitle goes here',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(_alertWithTitleText),
                  onBackClick: () {
                    print('back button clicked');
                  },
                  onCloseClick: () {
                    print('close button clicked');
                  },
                  actions: <Widget>[
                    Wrap(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(
                                context, DialogDemoAction.cancel.toString());
                          },
                        ),
                        FlatButton(
                          child: const Text('DISCARD'),
                          onPressed: () {
                            Navigator.pop(
                                context, DialogDemoAction.discard.toString());
                          },
                        ),
                      ],
                    )
                  ],
                  children: <Widget>[
                    Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key("key"),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
//                        setState(() {
//                          items.removeAt(index);
//                        });

                        // Then show a snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("dismissed")));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text('Dismissible Item')),
                    ),
                    DialogDemoItem(
                      icon: Icons.account_circle,
                      color: theme.primaryColor,
                      text: 'username@gmail.com',
                      onPressed: () {
                        Navigator.pop(context, 'username@gmail.com');
                      },
                    ),
                    DialogDemoItem(
                      icon: Icons.account_circle,
                      color: theme.primaryColor,
                      text: 'user02@gmail.com',
                      onPressed: () {
                        Navigator.pop(context, 'user02@gmail.com');
                      },
                    ),
                    DialogDemoItem(
                      icon: Icons.add_circle,
                      text: 'add account',
                      color: theme.disabledColor,
                    ),
                    DialogDemoItem(
                      icon: Icons.add_circle,
                      text: 'add account',
                      color: theme.disabledColor,
                    ),
                    DialogDemoItem(
                      icon: Icons.add_circle,
                      text: 'add account',
                      color: theme.disabledColor,
                    ),
                    Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key("key1"),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
//                        setState(() {
//                          items.removeAt(index);
//                        });

                        // Then show a snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("dismissed")));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text('Dismissible Item')),
                    ),
                  ],
                ),
              );
            },
          ),
          RaisedButton(
            child: const Text('CONFIRMATION'),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: _selectedTime,
              ).then<void>((TimeOfDay value) {
                if (value != null && value != _selectedTime) {
                  _selectedTime = value;
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('You selected: ${value.format(context)}'),
                  ));
                }
              });
            },
          ),
          RaisedButton(
            child: const Text('FULLSCREEN'),
            onPressed: () {},
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
}
