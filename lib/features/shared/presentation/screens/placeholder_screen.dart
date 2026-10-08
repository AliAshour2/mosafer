import 'package:flutter/material.dart';

import '../../../../core/design_system/components/feedback/app_empty_state.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: AppEmptyState(
        title: title,
        description: 'This route is reserved for future feature scaffolding.',
        icon: Icons.construction_rounded,
      ),
    );
  }
}
