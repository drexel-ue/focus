import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
