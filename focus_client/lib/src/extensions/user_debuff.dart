import 'dart:ui';

import 'package:focus_client/focus_client.dart';

extension UserDeuffX on UserDebuff {
  Color get color {
    return switch (this) {
      UserDebuff.fatigued => AppColors.dullBrown,
      UserDebuff.undisciplined => AppColors.dullGray,
      UserDebuff.dunce => AppColors.drab,
      UserDebuff.slacker => AppColors.darkOliveGreen,
      UserDebuff.coldMuscle => AppColors.icyBlue,
    };
  }

  String get description {
    return switch (this) {
      UserDebuff.fatigued => 'The [Player] is not well rested. -5% to all exp gain.',
      UserDebuff.undisciplined =>
        'The [Player] has failed to complete a [Task] or [Routine] in the past 3 days. -5% to all exp gain.',
      UserDebuff.dunce =>
        'The [Player] has failed to complete an intelligence based [Task] or [Routine] in the past 3 days. -2% to intelligence exp gain.',
      UserDebuff.slacker =>
        'The [Player] has failed to complete a strength or agility based [Task] or [Routine] in the past 3 days. -2% to vitality exp gain.',
      UserDebuff.coldMuscle =>
        'The [Player] has failed to complete a warm up. -2% to strength and agility exp gain.',
    };
  }
}
