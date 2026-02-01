// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CardTestFlow]
class CardTestRoute extends PageRouteInfo<void> {
  const CardTestRoute({List<PageRouteInfo>? children})
      : super(
          CardTestRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CardTestFlow());
    },
  );
}

/// generated route for
/// [CreateCardFlow]
class CreateCardRoute extends PageRouteInfo<void> {
  const CreateCardRoute({List<PageRouteInfo>? children})
      : super(
          CreateCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateCardFlow());
    },
  );
}

/// generated route for
/// [HomeFlow]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomeFlow());
    },
  );
}

/// generated route for
/// [MainFlow]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MainFlow());
    },
  );
}
