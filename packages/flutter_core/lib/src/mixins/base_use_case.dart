import 'package:flutter/foundation.dart';

mixin BaseUseCase<T, Params> {
  @protected
  T call({required Params params});
}

mixin BaseUseCaseNoParams<T> {
  @protected
  T call();
}
