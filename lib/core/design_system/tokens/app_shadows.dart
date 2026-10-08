import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const none = <BoxShadow>[];

  static const small = <BoxShadow>[
    BoxShadow(
      color: Color(0x0A171717),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const medium = <BoxShadow>[
    BoxShadow(
      color: Color(0x12171717),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const large = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A171717),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}
