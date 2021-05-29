import 'package:bloc/bloc.dart';
import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:meta/meta.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository repository;
  final TodoCubit todoCubit;

  EditTodoCubit({this.repository, this.todoCubit}) : super(EditTodoInitial());

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo.id).then((isCompleted) {
       if(isCompleted){
          todoCubit.deleteTodo(todo);
          emit(TodoEdited());
       }
    });
  }

  void updateTodo(Todo todo, message) {
    if(message.toString().isNotEmpty){
      repository.updateTodo(todo.id, message).then((isUpdated){
        if(isUpdated){
          todo.todoMessage = message;
          todoCubit.updateTodoList();
          emit(TodoEdited());
        }
      });

    }else if(message.toString().isEmpty){
      emit(EditTodoError(error: 'Enter something'));
    }
  }
}
