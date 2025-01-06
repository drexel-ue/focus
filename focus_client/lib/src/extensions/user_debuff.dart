import 'dart:ui';

import 'package:focus_client/focus_client.dart';
import 'package:focus_client/src/colors.dart';

extension UserDeuffX on UserDebuff {
  Color get color {
    return switch (this) {
      UserDebuff.fatigued => AppColors.dullBrown,
    };
  }
}
