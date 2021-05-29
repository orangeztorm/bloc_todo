import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String appTitle;
  final IconData iconData;
  final Function function;
  final Widget body;

  const SimplePage(
      {Key key, this.appTitle, this.iconData, this.function, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          InkWell(
            onTap: function,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(iconData),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
