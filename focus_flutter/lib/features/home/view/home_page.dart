import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:go_router/go_router.dart';

/// Home Page.
@immutable
class HomePage extends ConsumerWidget {
  /// Constructs a const [HomePage].
  const HomePage({super.key});

  /// Path.
  static const path = '/';

  /// [GoRoute].
  static GoRoute route = GoRoute(
    path: path,
    pageBuilder: defaultPageBuilder(const HomePage()),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Hello ${user.fullName}',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox.square(
                dimension: 250.0,
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.white,
                  child: Padding(
                    padding: allPadding2,
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.black,
                      child: user.profileImageUrl != null
                          ? Image.network(user.profileImageUrl!)
                          : SvgPicture.asset(AppAssets.defaultAvatar),
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
