import 'index.dart';

class Repository {

  final NetworkService networkService;
  Repository(this.networkService);


  Future<List<Todo>> fetchTodos () async{
    final todoRaw = await networkService.fetchTodos();
    return todoRaw.map((e) => Todo.fromJson(e)).toList();
  }

  void changeCompletion(bool isCompleted , int id) {

  }

}
