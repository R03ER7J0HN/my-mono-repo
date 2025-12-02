import 'package:get_it/get_it.dart';
import 'package:location_tracking/src/data/datasources/geolocator_data_source.dart';
import 'package:location_tracking/src/data/repositories/geolocator_repository.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';

export 'src/domain/entities/location_entity.dart';
export 'src/domain/failures/location_failure.dart';
export 'src/domain/repositories/location_repository.dart';

export 'src/presentation/cubit/location_cubit.dart';
export 'src/presentation/cubit/location_state.dart';
export 'src/presentation/widgets/company_location_map.dart';

class LocationTracking {
  const LocationTracking._();

  static void initialize(GetIt di) {
    di.registerLazySingleton<LocationRepository>(
      () => const GeolocatorRepository(GeolocatorDataSource()),
    );
  }
}
