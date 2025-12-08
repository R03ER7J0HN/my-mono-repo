import 'dart:async';
import 'dart:ui';

import 'package:authentication/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/application/cubit/app_cubit.dart';
import 'package:job_application_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:job_application_tracker/features/profile/cubit/profile_state.dart';
import 'package:job_application_tracker/features/profile/widgets/reauth_dialog.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';
import 'package:job_application_tracker/widgets/confirmation_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit(
          GetIt.I<AuthenticationRepository>(),
        );
        unawaited(cubit.loadProfile());

        return cubit;
      },
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (message) {
                  context.showSnackBar(
                    message,
                    type: SnackBarType.error,
                  );
                },
                loggedOut: context.read<AppCubit>().logout,
                accountDeleted: () {
                  context.showSnackBar(
                    'Account deleted successfully',
                    type: SnackBarType.success,
                  );
                  context.read<AppCubit>().logout();
                },
                requiresReauth: () async {
                  final password = await showDialog<String>(
                    context: context,
                    builder: (context) => const ReauthDialog(),
                  );

                  if (password != null && context.mounted) {
                    unawaited(
                      context.cubit.reauthenticateAndDelete(password),
                    );
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (user) => _buildProfileContent(context, user),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserEntity user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileHeader(context, user),
          const SizedBox(height: 32),
          _buildGlassCard(
            context,
            children: [
              _buildInfoTile(
                context,
                Icons.email_outlined,
                'Email',
                user.email ?? 'No Email',
              ),
              const Divider(height: 1),
              _buildInfoTile(
                context,
                Icons.fingerprint,
                'UID',
                user.uid,
              ),
              const Divider(height: 1),
              _buildInfoTile(
                context,
                Icons.person_outline,
                'Display Name',
                'Not set',
              ),
              const Divider(height: 1),
              _buildInfoTile(
                context,
                Icons.phone_outlined,
                'Phone Number',
                'Not set',
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildActionButtons(context),
          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserEntity user) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: colorScheme.surface,
            child: Icon(
              Icons.person,
              size: 50,
              color: colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.email ?? 'User',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Job Seeker',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: context.cubit.logOut,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Log Out'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: TextButton.icon(
            onPressed: () => _showDeleteConfirmation(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            label: const Text('Delete Account'),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    unawaited(
      ConfirmationBottomSheet.show(
        context,
        title: 'Delete Account',
        message: '''
Are you sure you want to delete your account? This action cannot be undone.''',
        confirmWidget: const Text('Delete'),
        isDestructive: true,
        onConfirm: () => context.cubit.deleteAccount(),
      ),
    );
  }
}

extension _CubitX on BuildContext {
  ProfileCubit get cubit => read<ProfileCubit>();
}
