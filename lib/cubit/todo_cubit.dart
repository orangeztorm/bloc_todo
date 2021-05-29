import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {

  final Repository repository;
  TodoCubit({this.repository}) : super(TodoInitial());

  void fetchTodos() {
    repository.fetchTodos().then((todos){
      Timer(Duration(seconds: 3),() {
        emit(TodoLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id);
  }
}
