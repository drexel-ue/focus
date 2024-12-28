import 'package:clerk_flutter/clerk_flutter.dart' hide outlineInputBorder;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart' show focusedOutlineInputBorder, outlineInputBorder;
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/auth/repository/clerk_auth_provider.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:google_fonts/google_fonts.dart';

/// App.
@immutable
class FocusApp extends ConsumerWidget {
  /// Constructs a const [FocusApp].
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clerkAuthProvider = ref.watch(clerkAuthProviderProvider);

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
              theme: ThemeData(
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme: GoogleFonts.robotoTextTheme().apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.black,
                  surface: Colors.black,
                  primary: Colors.white,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  contentPadding: allPadding8,
                  border: outlineInputBorder,
                  focusedBorder: focusedOutlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.white,
                  selectionHandleColor: Colors.white,
                  selectionColor: Colors.white12,
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Material(child: SafeArea(child: child!));
              },
            ),
          ),
        );
      },
    );
  }
}
