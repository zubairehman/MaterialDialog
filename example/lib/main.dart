import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ui/demo/dialog_demo.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Material(
          child: DialogDemo(),
        ),
      ),
    );
  }
}
