import 'package:clerk_flutter/clerk_flutter.dart' hide outlineInputBorder;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/persistence.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/app/theme.dart';
import 'package:focus_flutter/features/auth/repository/clerk_auth_provider.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';

/// App.
@immutable
class FocusApp extends ConsumerStatefulWidget {
  /// Constructs a const [FocusApp].
  const FocusApp({super.key});

  @override
  ConsumerState<FocusApp> createState() => _FocusAppState();
}

class _FocusAppState extends ConsumerState<FocusApp> {
  late final Future<void> _initalizeFuture;

  @override
  void initState() {
    super.initState();
    RendererBinding.instance.deferFirstFrame();
    _initalizeFuture = _initialize();
  }

  Future<void> _initialize() async {
    await ref.read(persistenceRepositoryProvider).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final clerkAuthProvider = ref.watch(clerkAuthProviderProvider);
    ref.listen(clerkAuthProviderProvider, (_, next) {
      if (next.hasValue) {
        RendererBinding.instance.allowFirstFrame();
      }
    });
    return FutureBuilder(
      future: _initalizeFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return clerkAuthProvider.when(
          loading: () => emptyWidget,
          // FIXME(drexel-ue): what would we like to show?
          error: (Object error, StackTrace stackTrace) => emptyWidget,
          data: (ClerkAuthProvider data) {
            return GestureDetector(
              onTap: () {
                if (FocusManager.instance.primaryFocus?.hasFocus == true) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
                ref.read(homeRepositoryProvider.notifier).closeMenu();
              },
              child: ClerkAuth(
                auth: data,
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Focus',
                  routerConfig: ref.read(goRouterProvider),
                  theme: generateTheme(),
                  builder: (BuildContext context, Widget? child) {
                    return Material(child: SafeArea(child: child!));
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
