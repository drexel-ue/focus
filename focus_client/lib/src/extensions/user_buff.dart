import 'dart:ui';

import 'package:focus_client/focus_client.dart';
import 'package:focus_client/src/colors.dart';

extension UserBuffX on UserBuff {
  Color get color {
    return switch (this) {
      UserBuff.rested => AppColors.softBlue,
    };
  }
}
