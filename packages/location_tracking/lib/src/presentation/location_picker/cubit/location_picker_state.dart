import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';

part 'location_picker_state.freezed.dart';

@freezed
sealed class LocationPickerState with _$LocationPickerState {
  const factory LocationPickerState.initial() = _Initial;
  const factory LocationPickerState.loading() = _Loading;
  const factory LocationPickerState.success({
    required LocationEntity currentLocation,
  }) = _Success;
  const factory LocationPickerState.failure({
    required String errorMessage,
  }) = _Failure;
  const factory LocationPickerState.permissionDenied({
    required LocationPermissionStatus permissionStatus,
    required String errorMessage,
  }) = _PermissionDenied;
  const factory LocationPickerState.serviceDisabled({
    required String errorMessage,
  }) = _ServiceDisabled;
}
