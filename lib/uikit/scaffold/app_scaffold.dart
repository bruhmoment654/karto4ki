import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/uikit/background/shader_background.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
    this.useSafeArea = true,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = useSafeArea ? SafeArea(child: body) : body;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final fab = floatingActionButton;
    final adjustedFab = fab != null && bottomPadding > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: fab,
          )
        : fab;

    final settings = context.read<IAppScope>().settingsStorage.get();
    final accentColor = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        ShaderBackground(
          animationEnabled: settings.shaderAnimationEnabled,
          accentColor: accentColor,
        ),
        Scaffold(
          appBar: appBar,
          body: content,
          drawer: drawer,
          endDrawer: endDrawer,
          floatingActionButton: adjustedFab,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: backgroundColor ?? Colors.transparent,
          floatingActionButtonLocation: floatingActionButtonLocation ??
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }
}
