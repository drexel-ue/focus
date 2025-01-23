import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';

/// Displays the [User]'s profile image or a default avatar.
@immutable
class UserAvatar extends ConsumerWidget {
  /// Constructs a const [UserAvatar].
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    return SizedBox.square(
      dimension: 64.0,
      child: Material(
        type: MaterialType.circle,
        color: AppColors.white,
        child: Padding(
          padding: allPadding2,
          child: Material(
            clipBehavior: Clip.antiAlias,
            type: MaterialType.circle,
            color: AppColors.black,
            child: CachedNetworkImage(
              imageUrl: user.profileImageUrl ?? '',
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 300),
              progressIndicatorBuilder: (
                BuildContext context,
                String url,
                DownloadProgress progress,
              ) {
                if (progress.progress case double value) {
                  final percent = (value * 100).round();
                  return Center(child: Text('$percent%'));
                }
                return const Center(child: Text('100%'));
              },
              errorWidget: (BuildContext context, String url, Object error) {
                return SvgPicture.asset(AppAssets.defaultAvatar);
              },
            ),
          ),
        ),
      ),
    );
  }
}
