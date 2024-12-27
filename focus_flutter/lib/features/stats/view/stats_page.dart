import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';

/// Stats Page.
@immutable
class StatsPage extends ConsumerWidget {
  /// Construcs a const [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(user.fullName),
              ),
              horizontalMargin16,
              SizedBox.square(
                dimension: 64.0,
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.white,
                  child: Padding(
                    padding: allPadding2,
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.black,
                      child: Image.network(
                        user.profileImageUrl ?? '',
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return SvgPicture.asset(AppAssets.defaultAvatar);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
