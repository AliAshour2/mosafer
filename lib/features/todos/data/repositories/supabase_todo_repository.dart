import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class SupabaseTodoRepository implements TodoRepository {
  const SupabaseTodoRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Todo>> fetchTodos() async {
    final rows = await _client.from('todos').select('name');

    return rows.map((row) {
      final name = row['name'];
      if (name is! String) {
        throw const FormatException(
          'Expected each todo row to have a string "name".',
        );
      }

      return Todo(name: name);
    }).toList(growable: false);
  }
}
