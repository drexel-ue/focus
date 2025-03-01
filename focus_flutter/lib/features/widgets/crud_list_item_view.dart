import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_checkbox.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';

/// Gets a nullable String from [T].
typedef GetStringFromItem<T> = String? Function(T item);

/// View for a list items in a CRUD screen.
@immutable
class CrudListItemView<T> extends StatelessWidget {
  /// Constructs a const [CrudListItemView].
  const CrudListItemView({
    super.key,
    required this.items,
    required this.getTitle,
    required this.getDescription,
    required this.onAddItem,
    required this.onDeleteItem,
    required this.onItemTapped,
    this.onCheckboxTapped,
    this.onTrailingTapped,
    this.trailing,
  });

  /// Items to display.
  final List<T> items;

  /// Getter for title.
  final GetStringFromItem<T> getTitle;

  /// Getter for description.
  final GetStringFromItem<T> getDescription;

  /// Callback to run when add icon tapped.
  final VoidCallback onAddItem;

  /// Callback to run when delete icon tapped.
  final ValueChanged<T> onDeleteItem;

  /// Callback to run when item tapped.
  final ValueChanged<T> onItemTapped;

  /// Callback to run when checkbox tapped. Only used for [Task]s.
  final ValueChanged<Task>? onCheckboxTapped;

  /// Callback to run when trailing tapped.
  final ValueChanged<T>? onTrailingTapped;

  /// Trailing widget.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: SizedBox(
          width: 200.0,
          child: FocusButton(
            onTap: () => onAddItem(),
            child: Text('Create $T'),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => onAddItem(),
            icon: const Icon(Icons.add, color: AppColors.white),
          ),
        ),
        Expanded(
          child: ScrollShadow(
            child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                bool showDelete = true;
                if (T == Task && (item as Task).completed) {
                  showDelete = false;
                }
                return Padding(
                  padding: bottomPadding16,
                  child: Slidable(
                    enabled: showDelete,
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        if (showDelete) //
                          SlidableAction(
                            onPressed: (_) => onDeleteItem(item),
                            icon: Icons.delete_forever_sharp,
                            backgroundColor: AppColors.vibrantRed,
                            foregroundColor: AppColors.white,
                          ),
                      ],
                    ),
                    child: SizedBox(
                      height: 56.0,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () => onItemTapped(item),
                        child: Row(
                          children: [
                            if (T == Task)
                              FocusCheckbox(
                                onTap: (item as Task).completed
                                    ? null
                                    : () => onCheckboxTapped?.call(item as Task),
                                selected: (item as Task).completed,
                              ),
                            horizontalMargin16,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTitle(item)!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextTheme.of(context).titleMedium,
                                  ),
                                  if (getDescription(item) case String description) ...[
                                    Text(
                                      description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (trailing case Widget trailing) ...[
                              horizontalMargin16,
                              InkWell(
                                onTap: onTrailingTapped != null //
                                    ? () => onTrailingTapped!(item)
                                    : null,
                                child: SizedBox.square(
                                  dimension: 48.0,
                                  child: Center(
                                    child: SizedBox.square(
                                      dimension: 24.0,
                                      child: trailing,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            horizontalMargin16,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
