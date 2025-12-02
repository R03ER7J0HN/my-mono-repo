import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';

import 'package:location_tracking/src/presentation/cubit/location_state.dart';

class LocationCubit extends Cubit<LocationState> with SafeEmitMixin {
  LocationCubit(this._repository) : super(const LocationState());
  final LocationRepository _repository;

  Future<void> getCurrentLocation() async {
    safeEmit(state.copyWith(status: LocationStatus.loading));

    final result = await _repository.getCurrentLocation();
    result.fold(
      onFailure: (failure) => safeEmit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      onSuccess: (location) => safeEmit(
        state.copyWith(
          status: LocationStatus.success,
          currentLocation: location,
        ),
      ),
    );
  }

  double calculateDistance(LocationEntity target) {
    if (state.currentLocation == null) return 0;
    return _repository.calculateDistance(state.currentLocation!, target);
  }
}
