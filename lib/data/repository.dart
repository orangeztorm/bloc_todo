import 'index.dart';

class Repository {

  final NetworkService networkService;
  Repository(this.networkService);


  Future<List<Todo>> fetchTodos () async{
    final todoRaw = await networkService.fetchTodos();
    return todoRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted , int id) async {
    final patchObj = {
      "isCompleted" : isCompleted.toString()
    };
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String message) async {
    final todoObj = {
      "todo" : message,
      "isCompleted": "false"
    };
    final todoMap =  await networkService.addTodo(todoObj);

    if(todoMap == null) return null;
    return Todo.fromJson(todoMap);
  }

}
