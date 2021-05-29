import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/data/index.dart';
import 'package:bloc_todo/ui/widgets/index.dart';
import 'package:bloc_todo/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).fetchTodos();
    return SimplePage(
      appTitle: 'Todos',
      iconData: Icons.add,
      function: () => Navigator.pushNamed(context, ADD_TODO_ROUTE),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        if (!(state is TodoLoaded))
          return Center(child: CircularProgressIndicator());

        final todos = (state as TodoLoaded).todos;

        return SingleChildScrollView(
            child: Column(
          children: todos.map((e) => _todo(e, context)).toList(),
        ));
      }),
    );
  }

  Widget _todo(Todo todo, context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, EDIT_TODO_ROUTE),
      child: Dismissible(
          key: Key(todo.id.toString()),
          background: Container(color: Colors.indigo),
          confirmDismiss: (_) async {
            BlocProvider.of<TodoCubit>(context).changeCompletion(todo);
            return false;
          },
          child: _todoTile(todo, context)),
    );
  }

  Widget _todoTile(Todo todo, context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(color: Colors.grey[200])
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo)
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo){
    return Container(
       width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 4.0,
          color: todo.isCompleted ? Colors.green : Colors.red
        )
      ),
    );
  }
}
