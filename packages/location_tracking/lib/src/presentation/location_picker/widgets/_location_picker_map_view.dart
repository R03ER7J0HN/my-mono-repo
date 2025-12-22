import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/presentation/location_picker/widgets/_location_info_card.dart';

import 'package:location_tracking/src/presentation/places_search/places_search.dart';

/// The map view for the location picker.
///
/// This widget manages the map controller and selection state internally.
class LocationPickerMapView extends StatefulWidget {
  const LocationPickerMapView({
    required this.currentLocation,
    super.key,
    this.initialLocation,
    this.initialAddress,
  });

  /// The user's current location from the device.
  final LocationEntity currentLocation;

  /// Initial location to display on the map.
  final LocationEntity? initialLocation;

  /// Initial address to display.
  final String? initialAddress;

  @override
  State<LocationPickerMapView> createState() => _LocationPickerMapViewState();
}

class _LocationPickerMapViewState extends State<LocationPickerMapView> {
  late final ValueNotifier<LocationEntity?> _selectionNotifier;

  GoogleMapController? _mapController;

  static const _defaultLocation = LatLng(14.5995, 120.9842);
  static const double _margin = 16;

  @override
  void initState() {
    super.initState();

    final initialLocation = widget.initialLocation;
    final initialLatLng = initialLocation != null
        ? LatLng(initialLocation.latitude, initialLocation.longitude)
        : LatLng(
            widget.currentLocation.latitude,
            widget.currentLocation.longitude,
          );

    _selectionNotifier = ValueNotifier(
      LocationEntity(
        latitude: initialLatLng.latitude,
        longitude: initialLatLng.longitude,
        address: widget.initialAddress,
      ),
    );
  }

  @override
  void dispose() {
    _selectionNotifier.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onPlaceSelected(PlaceDetailsEntity details) {
    _selectionNotifier.value = LocationEntity(
      latitude: details.latitude,
      longitude: details.longitude,
      address: details.formattedAddress ?? details.name,
    );

    _animateToLocation(LatLng(details.latitude, details.longitude), zoom: 17);
  }

  void _onMyLocationPressed() {
    final location = LatLng(
      widget.currentLocation.latitude,
      widget.currentLocation.longitude,
    );

    _selectionNotifier.value = LocationEntity(
      latitude: location.latitude,
      longitude: location.longitude,
      address: widget.initialAddress,
    );

    _animateToLocation(location);
  }

  void _animateToLocation(LatLng location, {double zoom = 15}) {
    if (_mapController != null) {
      unawaited(
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(location, zoom),
        ),
      );
    }
  }

  void _onConfirm() {
    final location = _selectionNotifier.value;

    if (location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location on the map')),
      );
      return;
    }

    Navigator.of(context).pop(
      (
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<LocationEntity?>(
            valueListenable: _selectionNotifier,
            builder: (context, location, _) {
              return TextButton(
                onPressed: location == null ? null : _onConfirm,
                child: Text(
                  'DONE',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<LocationEntity?>(
            valueListenable: _selectionNotifier,
            builder: (context, location, _) {
              final selectedLocation = location != null
                  ? LatLng(location.latitude, location.longitude)
                  : null;

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: selectedLocation ?? _defaultLocation,
                  zoom: 12,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;

                  if (selectedLocation != null) {
                    _animateToLocation(selectedLocation);
                  }
                },
                onTap: (coordinate) {
                  _selectionNotifier.value = LocationEntity(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude,
                  );
                },
                markers: selectedLocation != null
                    ? {
                        Marker(
                          markerId: const MarkerId('selected'),
                          position: selectedLocation,
                        ),
                      }
                    : {},
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              );
            },
          ),
          Positioned(
            top: _margin,
            left: _margin,
            right: _margin,
            child: Card(
              elevation: 4,
              child: PlacesSearchField(
                onPlaceSelected: _onPlaceSelected,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _selectionNotifier,
            builder: (context, location, _) {
              return Positioned(
                right: _margin,
                bottom: location?.address == null ? 70 + _margin : 80 + _margin,
                child: FloatingActionButton.small(
                  heroTag: 'my_location',
                  onPressed: _onMyLocationPressed,
                  child: const Icon(Icons.my_location),
                ),
              );
            },
          ),
          Positioned(
            bottom: _margin,
            left: _margin,
            right: _margin,
            child: ValueListenableBuilder<LocationEntity?>(
              valueListenable: _selectionNotifier,
              builder: (context, location, _) {
                if (location == null) return const SizedBox.shrink();

                return LocationInfoCard(
                  location: LatLng(location.latitude, location.longitude),
                  address: location.address,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
