import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';

import 'package:location_tracking/src/presentation/cubit/location_cubit.dart';
import 'package:location_tracking/src/presentation/cubit/location_state.dart';

class CompanyLocationMap extends StatelessWidget {
  const CompanyLocationMap({required this.companyLocations, super.key});

  final List<LocationEntity> companyLocations;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(
        GetIt.I<LocationRepository>(),
      ),
      child: _CompanyLocationMapView(companyLocations: companyLocations),
    );
  }
}

class _CompanyLocationMapView extends StatefulWidget {
  const _CompanyLocationMapView({required this.companyLocations});
  final List<LocationEntity> companyLocations;

  @override
  State<_CompanyLocationMapView> createState() =>
      _CompanyLocationMapViewState();
}

class _CompanyLocationMapViewState extends State<_CompanyLocationMapView> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    unawaited(context.read<LocationCubit>().getCurrentLocation());
    _updateMarkers(null);
  }

  void _updateMarkers(LocationEntity? currentLocation) {
    final newMarkers = <Marker>{};

    // Add company markers
    for (var i = 0; i < widget.companyLocations.length; i++) {
      final company = widget.companyLocations[i];
      double? distance;
      if (currentLocation != null) {
        distance = context.read<LocationCubit>().calculateDistance(company);
      }

      newMarkers.add(
        Marker(
          markerId: MarkerId('company_$i'),
          position: LatLng(company.latitude, company.longitude),
          infoWindow: InfoWindow(
            title: 'Company Location',
            snippet: distance != null
                ? 'Distance: ${(distance / 1000).toStringAsFixed(2)} km'
                : 'Calculating distance...',
          ),
        ),
      );
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state.status == LocationStatus.success) {
          _updateMarkers(state.currentLocation);
          if (state.currentLocation != null) {
            unawaited(
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(
                    state.currentLocation!.latitude,
                    state.currentLocation!.longitude,
                  ),
                  12,
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state.status == LocationStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == LocationStatus.failure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers,
          onMapCreated: (controller) {
            _mapController = controller;
            if (state.currentLocation != null) {
              unawaited(
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(
                      state.currentLocation!.latitude,
                      state.currentLocation!.longitude,
                    ),
                    12,
                  ),
                ),
              );
            }
          },
          myLocationEnabled: true,
        );
      },
    );
  }
}
