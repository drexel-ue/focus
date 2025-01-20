import 'dart:ui';

import 'package:focus_client/focus_client.dart';

extension UserBuffX on UserBuff {
  Color get color {
    return switch (this) {
      UserBuff.rested => AppColors.softBlue,
      UserBuff.warmedUp => AppColors.redOrange,
      UserBuff.disciplined => AppColors.navyBlue,
      UserBuff.studied => AppColors.deepPurple,
      UserBuff.trained => AppColors.vibrantRed,
    };
  }

  String get description {
    return switch (this) {
      UserBuff.rested =>
        'The [Player] is well rested. +2% to perception and intelligence exp gain.',
      UserBuff.warmedUp =>
        'The [Player] has completed a physical warmup. +2% to strength and agility exp gain.',
      UserBuff.disciplined =>
        'The [Player] has completed at least one [Routine] everyday for the past week. +5% to all exp gain.',
      UserBuff.studied =>
        'The [Player] has studied an intellectual subject. +2% to intelligence exp gain.',
      UserBuff.trained => 'The [Player] has completed physical training. +2% to vitality exp gain.',
    };
  }
}
