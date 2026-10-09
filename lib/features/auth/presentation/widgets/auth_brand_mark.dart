import 'package:flutter/material.dart';

import '../../../../core/design_system/app_design_system.dart';

class AuthBrandMark extends StatelessWidget {
  const AuthBrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: AppSizes.minimumTapTarget,
        height: AppSizes.minimumTapTarget,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: Icon(
          Icons.near_me_outlined,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
