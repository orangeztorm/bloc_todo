import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/views/index.dart';
import 'index.dart';

class Routes {

  Repository repository;
  TodoCubit todoCubit;
  Routes(){
    repository = Repository(NetworkService());
    todoCubit = TodoCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: todoCubit,
                child: TodoScreen()
            ));
      case EDIT_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => EditTodoScreen());
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => AddTodoCubit(repository: repository, todoCubit: todoCubit),
                child: AddTodoScreen()
            ));
      default:
        return null;
    }
  }
}
