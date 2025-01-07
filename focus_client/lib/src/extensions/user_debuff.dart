import 'dart:ui';

import 'package:focus_client/focus_client.dart';

extension UserDeuffX on UserDebuff {
  Color get color {
    return switch (this) {
      UserDebuff.fatigued => AppColors.dullBrown,
      UserDebuff.undisciplined => AppColors.dullGray,
      UserDebuff.dunce => AppColors.drab,
      UserDebuff.slacker => throw UnimplementedError(),
    };
  }
}
