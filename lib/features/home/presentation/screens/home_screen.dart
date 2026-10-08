import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/components/feedback/app_loading.dart';
import '../../../todos/presentation/providers/todos_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: todos.when(
        loading: () => const AppLoadingIndicator(
          label: 'Loading todos',
        ),
        error: (error, stackTrace) => AppErrorState(
          message: 'We could not load the todos right now. Please try again.',
          onRetry: () => ref.invalidate(todosProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const AppEmptyState(
              title: 'No todos yet',
              description: 'There are no items to show right now.',
              icon: Icons.checklist_rounded,
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(items[index].name),
            ),
          );
        },
      ),
    );
  }
}
