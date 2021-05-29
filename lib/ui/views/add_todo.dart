import 'package:bloc_todo/cubit/index.dart';
import 'package:bloc_todo/ui/widgets/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key key}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      appTitle: 'Add Todo',
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
            Toast.show(state.error, context,
                duration: 3,
                backgroundColor: Colors.red,
                gravity: Toast.CENTER);
          }
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter todo message...."),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              final message = _controller.text;
              BlocProvider.of<AddTodoCubit>(context).addTodo(message);
            },
            child: _addButton(context))
      ],
    );
  }

  Widget _addButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) return CircularProgressIndicator();

            return Text(
              'Add Todo',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
