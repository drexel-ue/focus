import 'package:flutter/widgets.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/widgets/focus_chip.dart';

/// Used to add/remove [UserBuff]s to/from the [RoutineForm].
@immutable
class BuffSelector extends StatefulWidget {
  /// Constructs a const [BuffSelector].
  const BuffSelector({
    super.key,
    required this.controller,
    required this.selected,
    required this.onChanged,
  });

  /// Controller for [OverlayPortal].
  final OverlayPortalController controller;

  /// Selected values.
  final List<UserBuff> selected;

  /// On changed.
  final ValueChanged<List<UserBuff>> onChanged;

  @override
  State<BuffSelector> createState() => _BuffSelectorState();
}

class _BuffSelectorState extends State<BuffSelector> {
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: widget.controller,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          width: 400.0,
          child: CompositedTransformFollower(
            link: _layerLink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final buff in UserBuff.values)
              ],
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: FocusChip(
          label: 'Add buff(s)',
          onTap: () {},
        ),
      ),
    );
  }
}
