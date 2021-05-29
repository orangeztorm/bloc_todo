import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:meta/meta.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodoCubit todoCubit;

  AddTodoCubit({this.repository, this.todoCubit}) : super(AddTodoInitial());

  void addTodo(String message) {
    if(message.isEmpty){
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }
    emit(AddingTodo());
    Timer(Duration(seconds: 3),(){
      repository.addTodo(message).then((todo) {
        if(todo != null){
          todoCubit.addTodo(todo);
          emit(TodoAdded());
        }
      });
    });
  }
}
