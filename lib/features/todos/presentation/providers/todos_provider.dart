import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/supabase_client_provider.dart';
import '../../data/repositories/supabase_todo_repository.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

part 'todos_provider.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref) {
  return SupabaseTodoRepository(ref.watch(supabaseClientProvider));
}

@riverpod
Future<List<Todo>> todos(Ref ref) {
  return ref.watch(todoRepositoryProvider).fetchTodos();
}
