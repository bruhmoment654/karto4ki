import 'package:flutter/material.dart';
import 'package:karto4ki/feature/profile/presentation/profile_view.dart';

/// Profile screen.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements IProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

/// ViewModel interface for profile screen.
abstract interface class IProfileViewModel {}
