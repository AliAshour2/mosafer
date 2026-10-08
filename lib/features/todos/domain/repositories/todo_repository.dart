import '../entities/todo.dart';

abstract interface class TodoRepository {
  Future<List<Todo>> fetchTodos();
}
