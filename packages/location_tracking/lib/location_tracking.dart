import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location_tracking/src/data/datasources/geolocator_data_source.dart';
import 'package:location_tracking/src/data/datasources/places_remote_data_source.dart';
import 'package:location_tracking/src/data/repositories/geolocator_repository.dart';
import 'package:location_tracking/src/data/repositories/google_places_repository.dart';
import 'package:location_tracking/src/domain/entities/entities.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';
import 'package:location_tracking/src/domain/repositories/places_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

export 'src/domain/domain.dart';
export 'src/presentation/location_picker/location_picker.dart'
    show LocationPicker;

class LocationTracking {
  const LocationTracking._();

  static Future<void> initialize(
    GetIt di, {
    required PlacesApiConfig placesConfig,
  }) async {
    final packageInfo = await PackageInfo.fromPlatform();

    final dio = Dio(
      BaseOptions(
        headers: {
          'X-Android-Package': packageInfo.packageName,
          'X-Android-Cert': placesConfig.androidSha1Signature,
          'X-Ios-Bundle-Identifier': packageInfo.packageName,
        },
      ),
    );

    di
      // Google Places
      ..registerLazySingleton<PlacesRemoteDataSource>(
        () => PlacesRemoteDataSource(dio),
      )
      ..registerLazySingleton<PlacesRepository>(
        () => GooglePlacesRepository(
          dataSource: di.get<PlacesRemoteDataSource>(),
          apiKey: placesConfig.apiKey,
        ),
      )
      // Location Tracking
      ..registerLazySingleton<GeolocatorDataSource>(
        () => const GeolocatorDataSource(),
      )
      ..registerLazySingleton<LocationRepository>(
        () => GeolocatorRepository(
          di.get<GeolocatorDataSource>(),
        ),
      );
  }
}
