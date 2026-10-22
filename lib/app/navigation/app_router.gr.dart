// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthFlow]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AuthFlow());
    },
  );
}

/// generated route for
/// [DeveloperDebugFlow]
class DeveloperDebugRoute extends PageRouteInfo<void> {
  const DeveloperDebugRoute({List<PageRouteInfo>? children})
    : super(DeveloperDebugRoute.name, initialChildren: children);

  static const String name = 'DeveloperDebugRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DeveloperDebugFlow());
    },
  );
}

/// generated route for
/// [GroupDetailFlow]
class GroupDetailRoute extends PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({
    required String groupId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GroupDetailRoute.name,
         args: GroupDetailRouteArgs(groupId: groupId, key: key),
         rawPathParams: {'groupId': groupId},
         initialChildren: children,
       );

  static const String name = 'GroupDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GroupDetailRouteArgs>(
        orElse: () =>
            GroupDetailRouteArgs(groupId: pathParams.getString('groupId')),
      );
      return WrappedRoute(
        child: GroupDetailFlow(groupId: args.groupId, key: args.key),
      );
    },
  );
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({required this.groupId, this.key});

  final String groupId;

  final Key? key;

  @override
  String toString() {
    return 'GroupDetailRouteArgs{groupId: $groupId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupDetailRouteArgs) return false;
    return groupId == other.groupId && key == other.key;
  }

  @override
  int get hashCode => groupId.hashCode ^ key.hashCode;
}

/// generated route for
/// [GroupsListFlow]
class GroupsListRoute extends PageRouteInfo<void> {
  const GroupsListRoute({List<PageRouteInfo>? children})
    : super(GroupsListRoute.name, initialChildren: children);

  static const String name = 'GroupsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const GroupsListFlow());
    },
  );
}

/// generated route for
/// [HomeFlow]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

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
    : super(MainRoute.name, initialChildren: children);

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
    : super(MainTabRoute.name, initialChildren: children);

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
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileFlow());
    },
  );
}

/// generated route for
/// [ProfileMainFlow]
class ProfileMainRoute extends PageRouteInfo<void> {
  const ProfileMainRoute({List<PageRouteInfo>? children})
    : super(ProfileMainRoute.name, initialChildren: children);

  static const String name = 'ProfileMainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileMainFlow());
    },
  );
}

/// generated route for
/// [QuestionStatsFlow]
class QuestionStatsRoute extends PageRouteInfo<void> {
  const QuestionStatsRoute({List<PageRouteInfo>? children})
    : super(QuestionStatsRoute.name, initialChildren: children);

  static const String name = 'QuestionStatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const QuestionStatsFlow());
    },
  );
}

/// generated route for
/// [SettingsFlow]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SettingsFlow());
    },
  );
}

/// generated route for
/// [TestDetailFlow]
class TestDetailRoute extends PageRouteInfo<TestDetailRouteArgs> {
  TestDetailRoute({
    required String testId,
    bool mixup = false,
    int mixupMin = 1,
    int mixupMax = 5,
    String? groupId,
    bool openImport = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TestDetailRoute.name,
         args: TestDetailRouteArgs(
           testId: testId,
           mixup: mixup,
           mixupMin: mixupMin,
           mixupMax: mixupMax,
           groupId: groupId,
           openImport: openImport,
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
            TestDetailRouteArgs(testId: pathParams.getString('testId')),
      );
      return WrappedRoute(
        child: TestDetailFlow(
          testId: args.testId,
          mixup: args.mixup,
          mixupMin: args.mixupMin,
          mixupMax: args.mixupMax,
          groupId: args.groupId,
          openImport: args.openImport,
          key: args.key,
        ),
      );
    },
  );
}

class TestDetailRouteArgs {
  const TestDetailRouteArgs({
    required this.testId,
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    this.groupId,
    this.openImport = false,
    this.key,
  });

  final String testId;

  final bool mixup;

  final int mixupMin;

  final int mixupMax;

  final String? groupId;

  final bool openImport;

  final Key? key;

  @override
  String toString() {
    return 'TestDetailRouteArgs{testId: $testId, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, groupId: $groupId, openImport: $openImport, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TestDetailRouteArgs) return false;
    return testId == other.testId &&
        mixup == other.mixup &&
        mixupMin == other.mixupMin &&
        mixupMax == other.mixupMax &&
        groupId == other.groupId &&
        openImport == other.openImport &&
        key == other.key;
  }

  @override
  int get hashCode =>
      testId.hashCode ^
      mixup.hashCode ^
      mixupMin.hashCode ^
      mixupMax.hashCode ^
      groupId.hashCode ^
      openImport.hashCode ^
      key.hashCode;
}

/// generated route for
/// [TestMergeFlow]
class TestMergeRoute extends PageRouteInfo<TestMergeRouteArgs> {
  TestMergeRoute({
    required String initialTestId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TestMergeRoute.name,
         args: TestMergeRouteArgs(initialTestId: initialTestId, key: key),
         initialChildren: children,
       );

  static const String name = 'TestMergeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestMergeRouteArgs>();
      return WrappedRoute(
        child: TestMergeFlow(initialTestId: args.initialTestId, key: args.key),
      );
    },
  );
}

class TestMergeRouteArgs {
  const TestMergeRouteArgs({required this.initialTestId, this.key});

  final String initialTestId;

  final Key? key;

  @override
  String toString() {
    return 'TestMergeRouteArgs{initialTestId: $initialTestId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TestMergeRouteArgs) return false;
    return initialTestId == other.initialTestId && key == other.key;
  }

  @override
  int get hashCode => initialTestId.hashCode ^ key.hashCode;
}

/// generated route for
/// [TestsListFlow]
class TestsListRoute extends PageRouteInfo<void> {
  const TestsListRoute({List<PageRouteInfo>? children})
    : super(TestsListRoute.name, initialChildren: children);

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
    required String testId,
    bool swapSides = false,
    int answerIndex = 0,
    bool mixup = false,
    int mixupMin = 1,
    int mixupMax = 5,
    bool resume = false,
    String? groupId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TinderTestRoute.name,
         args: TinderTestRouteArgs(
           testId: testId,
           swapSides: swapSides,
           answerIndex: answerIndex,
           mixup: mixup,
           mixupMin: mixupMin,
           mixupMax: mixupMax,
           resume: resume,
           groupId: groupId,
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
            TinderTestRouteArgs(testId: pathParams.getString('testId')),
      );
      return WrappedRoute(
        child: TinderTestFlow(
          testId: args.testId,
          swapSides: args.swapSides,
          answerIndex: args.answerIndex,
          mixup: args.mixup,
          mixupMin: args.mixupMin,
          mixupMax: args.mixupMax,
          resume: args.resume,
          groupId: args.groupId,
          key: args.key,
        ),
      );
    },
  );
}

class TinderTestRouteArgs {
  const TinderTestRouteArgs({
    required this.testId,
    this.swapSides = false,
    this.answerIndex = 0,
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    this.resume = false,
    this.groupId,
    this.key,
  });

  final String testId;

  final bool swapSides;

  final int answerIndex;

  final bool mixup;

  final int mixupMin;

  final int mixupMax;

  final bool resume;

  final String? groupId;

  final Key? key;

  @override
  String toString() {
    return 'TinderTestRouteArgs{testId: $testId, swapSides: $swapSides, answerIndex: $answerIndex, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, resume: $resume, groupId: $groupId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TinderTestRouteArgs) return false;
    return testId == other.testId &&
        swapSides == other.swapSides &&
        answerIndex == other.answerIndex &&
        mixup == other.mixup &&
        mixupMin == other.mixupMin &&
        mixupMax == other.mixupMax &&
        resume == other.resume &&
        groupId == other.groupId &&
        key == other.key;
  }

  @override
  int get hashCode =>
      testId.hashCode ^
      swapSides.hashCode ^
      answerIndex.hashCode ^
      mixup.hashCode ^
      mixupMin.hashCode ^
      mixupMax.hashCode ^
      resume.hashCode ^
      groupId.hashCode ^
      key.hashCode;
}

/// generated route for
/// [UikitCatalogFlow]
class UikitCatalogRoute extends PageRouteInfo<void> {
  const UikitCatalogRoute({List<PageRouteInfo>? children})
    : super(UikitCatalogRoute.name, initialChildren: children);

  static const String name = 'UikitCatalogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UikitCatalogFlow();
    },
  );
}
