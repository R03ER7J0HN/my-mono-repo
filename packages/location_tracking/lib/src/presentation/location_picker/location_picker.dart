import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';
import 'package:location_tracking/src/presentation/location_picker/cubit/cubit.dart';
import 'package:location_tracking/src/presentation/location_picker/widgets/_location_error_view.dart';
import 'package:location_tracking/src/presentation/location_picker/widgets/_location_picker_map_view.dart';
import 'package:location_tracking/src/presentation/location_picker/widgets/_permission_denied_view.dart';
import 'package:location_tracking/src/presentation/location_picker/widgets/_service_disabled_view.dart';

/// A full-screen location picker that allows users to select a location.
///
/// Use [LocationPicker.show] to display the picker as a modal route.
class LocationPicker extends StatelessWidget {
  const LocationPicker({
    super.key,
    this.initialLocation,
    this.initialAddress,
  });

  final LocationEntity? initialLocation;
  final String? initialAddress;

  /// Shows the location picker as a full-screen modal.
  ///
  /// Returns a [LocationEntity] if the user confirms their selection,
  /// or `null` if the user cancels.
  static Future<LocationEntity?> show(
    BuildContext context, {
    LocationEntity? initialLocation,
    String? initialAddress,
  }) {
    return Navigator.of(context).push<LocationEntity>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => LocationPicker(
          initialLocation: initialLocation,
          initialAddress: initialAddress,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = LocationPickerCubit(
          GetIt.I<LocationRepository>(),
        );

        unawaited(cubit.initialize());
        return cubit;
      },
      child: _LocationPickerView(
        initialLocation: initialLocation,
        initialAddress: initialAddress,
      ),
    );
  }
}

class _LocationPickerView extends StatelessWidget {
  const _LocationPickerView({
    this.initialLocation,
    this.initialAddress,
  });

  final LocationEntity? initialLocation;
  final String? initialAddress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPickerCubit, LocationPickerState>(
      builder: (context, state) {
        final reinitialize = context.cubit.initialize;

        return state.maybeWhen(
          failure: (errorMessage) {
            return LocationErrorView(
              errorMessage: errorMessage,
              onRetry: reinitialize,
            );
          },
          permissionDenied: (permissionStatus, errorMessage) {
            return PermissionDeniedView(
              errorMessage: errorMessage,
              onOpenSettings: () {
                unawaited(
                  context.cubit.openAppSettings(),
                );
              },
              onRetry: reinitialize,
            );
          },
          serviceDisabled: (errorMessage) {
            return ServiceDisabledView(
              errorMessage: errorMessage,
              onOpenSettings: () {
                unawaited(
                  context.cubit.openLocationSettings(),
                );
              },
              onRetry: reinitialize,
            );
          },
          success: (currentLocation) {
            return LocationPickerMapView(
              currentLocation: currentLocation,
              initialLocation: initialLocation,
              initialAddress: initialAddress,
            );
          },
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

extension _CubitX on BuildContext {
  LocationPickerCubit get cubit => read<LocationPickerCubit>();
}
