import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

/// A mixin to prevent emitting states on a closed [Bloc] or [Cubit].
///
/// This is useful for asynchronous operations that might complete
/// after the widget and its corresponding BLoC have been disposed.
mixin SafeEmitMixin<State> on BlocBase<State> {
  /// Emits a new [state] only if the bloc has not been closed.
  void safeEmit(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
