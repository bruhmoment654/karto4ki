// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CardDetailFlow]
class CardDetailRoute extends PageRouteInfo<void> {
  const CardDetailRoute({List<PageRouteInfo>? children})
      : super(
          CardDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CardDetailFlow());
    },
  );
}

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

/// generated route for
/// [TestsListFlow]
class TestsListRoute extends PageRouteInfo<void> {
  const TestsListRoute({List<PageRouteInfo>? children})
      : super(
          TestsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TestsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TestsListFlow());
    },
  );
}
