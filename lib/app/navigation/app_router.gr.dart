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
/// [MainTabFlow]
class MainTabRoute extends PageRouteInfo<void> {
  const MainTabRoute({List<PageRouteInfo>? children})
      : super(
          MainTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MainTabFlow());
    },
  );
}

/// generated route for
/// [ProfileFlow]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileFlow());
    },
  );
}

/// generated route for
/// [TestDetailFlow]
class TestDetailRoute extends PageRouteInfo<TestDetailRouteArgs> {
  TestDetailRoute({
    required int testId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TestDetailRoute.name,
          args: TestDetailRouteArgs(
            testId: testId,
            key: key,
          ),
          rawPathParams: {'testId': testId},
          initialChildren: children,
        );

  static const String name = 'TestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TestDetailRouteArgs>(
          orElse: () =>
              TestDetailRouteArgs(testId: pathParams.getInt('testId')));
      return WrappedRoute(
          child: TestDetailFlow(
        testId: args.testId,
        key: args.key,
      ));
    },
  );
}

class TestDetailRouteArgs {
  const TestDetailRouteArgs({
    required this.testId,
    this.key,
  });

  final int testId;

  final Key? key;

  @override
  String toString() {
    return 'TestDetailRouteArgs{testId: $testId, key: $key}';
  }
}

/// generated route for
/// [TestMergeFlow]
class TestMergeRoute extends PageRouteInfo<TestMergeRouteArgs> {
  TestMergeRoute({
    required int initialTestId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TestMergeRoute.name,
          args: TestMergeRouteArgs(
            initialTestId: initialTestId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TestMergeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestMergeRouteArgs>();
      return WrappedRoute(
          child: TestMergeFlow(
        initialTestId: args.initialTestId,
        key: args.key,
      ));
    },
  );
}

class TestMergeRouteArgs {
  const TestMergeRouteArgs({
    required this.initialTestId,
    this.key,
  });

  final int initialTestId;

  final Key? key;

  @override
  String toString() {
    return 'TestMergeRouteArgs{initialTestId: $initialTestId, key: $key}';
  }
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

/// generated route for
/// [TinderTestFlow]
class TinderTestRoute extends PageRouteInfo<TinderTestRouteArgs> {
  TinderTestRoute({
    required int testId,
    bool swapSides = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TinderTestRoute.name,
          args: TinderTestRouteArgs(
            testId: testId,
            swapSides: swapSides,
            key: key,
          ),
          rawPathParams: {'testId': testId},
          initialChildren: children,
        );

  static const String name = 'TinderTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TinderTestRouteArgs>(
          orElse: () =>
              TinderTestRouteArgs(testId: pathParams.getInt('testId')));
      return WrappedRoute(
          child: TinderTestFlow(
        testId: args.testId,
        swapSides: args.swapSides,
        key: args.key,
      ));
    },
  );
}

class TinderTestRouteArgs {
  const TinderTestRouteArgs({
    required this.testId,
    this.swapSides = false,
    this.key,
  });

  final int testId;

  final bool swapSides;

  final Key? key;

  @override
  String toString() {
    return 'TinderTestRouteArgs{testId: $testId, swapSides: $swapSides, key: $key}';
  }
}
