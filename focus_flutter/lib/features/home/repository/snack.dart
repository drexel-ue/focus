import 'package:flutter/foundation.dart';
import 'package:focus_flutter/features/home/repository/snack_type.dart';

export 'package:focus_flutter/features/home/repository/snack_type.dart';

/// Message to display.
@immutable
class Snack {
  /// Constructs a const [Snack].
  const Snack({
    required this.message,
    this.type = SnackType.neutral,
    this.onTap,
  });

  /// Display text.
  final String message;

  /// Type.
  final SnackType type;

  /// Optional callback to be ran when [Snack] is tapped.
  final VoidCallback? onTap;
}
