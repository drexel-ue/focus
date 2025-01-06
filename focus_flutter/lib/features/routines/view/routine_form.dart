import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/routines/view/buff_selector.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Form for creating/editing a [Routine].
@immutable
class RoutineForm extends ConsumerStatefulWidget {
  /// Constructs a const [RoutineForm].
  const RoutineForm({
    super.key,
    required this.close,
    this.routine,
  });

  /// Callback to call when cancelling.
  final VoidCallback close;

  /// [Routine] to edit.
  final Routine? routine;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutineFormState();
}

class _RoutineFormState extends ConsumerState<RoutineForm> {
  late final _titleController = TextEditingController(text: widget.routine?.title)
    ..addListener(_listener);
  final _buffSelectorController = OverlayPortalController();
  late List<UserBuff> _buffs = widget.routine?.buffs ?? const <UserBuff>[];

  void _listener() => setState(() {});

  @override
  void dispose() {
    _titleController
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingCover(
      loading: ref.watch(routinesRepositoryProvider).isLoading,
      child: Padding(
        padding: allPadding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            verticalMargin16,
            BuffSelector(
              controller: _buffSelectorController,
              selected: _buffs,
              onChanged: (List<UserBuff> buffs) => setState(() => _buffs = buffs),
            ),
          ],
        ),
      ),
    );
  }
}
