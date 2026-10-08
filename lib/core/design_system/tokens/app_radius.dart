import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const none = 0.0;
  static const small = 6.0;
  static const medium = 10.0;
  static const large = 14.0;
  static const xlarge = 20.0;
  static const pill = 999.0;

  static const smallShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(small)),
  );
  static const mediumShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(medium)),
  );
  static const largeShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(large)),
  );
  static const xlargeShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(xlarge)),
  );
  static const pillShape = StadiumBorder();
}
