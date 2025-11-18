import 'package:flutter/foundation.dart';

abstract class BaseUseCase<T, Params> {
  const BaseUseCase();

  @protected
  T call({required Params params});
}

abstract class BaseUseCaseNoParams<T> {
  const BaseUseCaseNoParams();

  @protected
  T call();
}
