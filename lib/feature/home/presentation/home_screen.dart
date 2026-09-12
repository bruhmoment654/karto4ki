import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/home/presentation/home_view.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';

/// Container screen for nested navigation.
///
/// Responsible for displaying nested router and, if needed,
/// common navigation elements (e.g., bottom navigation bar).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements IHomeViewModel {
  @override
  StateStreamable<SyncState> get syncState => context.read<SyncBloc>();

  @override
  Widget build(BuildContext context) {
    return HomeView(viewModel: this);
  }
}

/// ViewModel interface for Home screen.
///
/// Defines interaction contract between [HomeScreen] and [HomeView].
abstract interface class IHomeViewModel {
  /// Состояние синхронизации: от него зависит бейдж на табе профиля.
  StateStreamable<SyncState> get syncState;
}
