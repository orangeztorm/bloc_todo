import 'package:flutter/material.dart';
import 'ui/views/index.dart';
import 'utils/index.dart';

void main() {
  runApp(TodoApp(routes: Routes(),));
}

class TodoApp extends StatelessWidget {
  final Routes routes;

  const TodoApp({Key key, this.routes}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes.generateRoute,
    );
  }
}