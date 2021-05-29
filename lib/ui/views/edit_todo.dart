import 'package:bloc_todo/data/index.dart';
import 'package:bloc_todo/ui/widgets/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:bloc_todo/cubit/index.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({Key key, this.todo}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage;
    return BlocListener<EditTodoCubit,EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Toast.show(state.error, context,
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.CENTER);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
                onTap:() => BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo) ,
                child: Icon(Icons.delete))
          ],
        ),
        body:_body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(hintText: "Enter Message....."),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap:() => BlocProvider.of<EditTodoCubit>(context)
                    .updateTodo(todo, _controller.text),
                child: _updateBtn(context))
          ],
        ),
      ),
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          'Update Todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
