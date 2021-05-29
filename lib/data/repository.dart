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

}
