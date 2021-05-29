import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/views/index.dart';
import 'index.dart';

class Routes {

  Repository repository;
  Routes(){
    repository = Repository(NetworkService());
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => TodoCubit(repository: repository),
                child: TodoScreen()
            ));
      case EDIT_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => AddTodoScreen());
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => EditTodoScreen());
      default:
        return null;
    }
  }
}
