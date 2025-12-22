import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';
import 'package:location_tracking/src/domain/repositories/places_repository.dart';
import 'package:location_tracking/src/presentation/places_search/cubit/cubit.dart';
import 'package:location_tracking/src/presentation/places_search/widgets/_predictions_dropdown.dart';

/// A search field widget with Google Places autocomplete functionality.
///
/// Wraps the internal view with a [BlocProvider] to manage state.
class PlacesSearchField extends StatelessWidget {
  const PlacesSearchField({
    required this.onPlaceSelected,
    super.key,
    this.debounceTime = const Duration(milliseconds: 400),
  });

  /// Called when a place is selected with its details.
  final ValueChanged<PlaceDetailsEntity> onPlaceSelected;

  /// Debounce time for search queries.
  final Duration debounceTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlacesSearchCubit(
        GetIt.I<PlacesRepository>(),
        debounceTime: debounceTime,
      ),
      child: _PlacesSearchFieldView(
        onPlaceSelected: onPlaceSelected,
      ),
    );
  }
}

class _PlacesSearchFieldView extends StatefulWidget {
  const _PlacesSearchFieldView({
    required this.onPlaceSelected,
  });

  final ValueChanged<PlaceDetailsEntity> onPlaceSelected;

  @override
  State<_PlacesSearchFieldView> createState() => _PlacesSearchFieldViewState();
}

class _PlacesSearchFieldViewState extends State<_PlacesSearchFieldView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  final _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  bool _isSelectingPlace = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _removeOverlay();

    _controller.dispose();
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();

    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      _removeOverlay();
      context.cubit.clearPredictions();
    }
  }

  void _onTextChanged(String query) {
    if (_isSelectingPlace) return;
    context.cubit.searchPlaces(query);
  }

  void _showOverlay(List<PlacePredictionEntity> predictions) {
    final renderBox = context.findRenderObject() as RenderBox?;

    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: renderBox?.size.width ?? 300,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 56),
            child: PredictionsDropdown(
              predictions: predictions,
              onPredictionSelected: _onPredictionSelected,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _onPredictionSelected(PlacePredictionEntity prediction) {
    _isSelectingPlace = true;
    _removeOverlay();

    _controller.text = prediction.description;
    _isSelectingPlace = false;

    _focusNode.unfocus();
    unawaited(context.cubit.selectPlace(prediction));
  }

  void _onPlaceDetailsReceived(PlaceDetailsEntity details) {
    widget.onPlaceSelected(details);
    context.cubit.clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacesSearchCubit, PlacesSearchState>(
      listener: (context, state) {
        final errorMessage = state.errorMessage;
        final selectedPlace = state.selectedPlace;

        // Handle predictions overlay
        if (state.predictions.isNotEmpty && _focusNode.hasFocus) {
          _showOverlay(state.predictions);
        } else if (state.predictions.isEmpty && !state.isSearching) {
          _removeOverlay();
        }

        // Show error if fetching details failed
        if (errorMessage != null && !state.isFetchingDetails) {
          _isSelectingPlace = false;
          context.showSnackBar(
            'Failed to get place details: $errorMessage',
            type: SnackBarType.error,
          );
        }

        // Return selected place details
        if (selectedPlace != null) {
          _onPlaceDetailsReceived(selectedPlace);
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
          buildWhen: (previous, current) {
            return previous.isSearching != current.isSearching ||
                previous.isFetchingDetails != current.isFetchingDetails;
          },
          builder: (context, state) {
            final isLoading = state.isSearching || state.isFetchingDetails;

            return TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onTextChanged,
              decoration: _buildDecoration(isLoading),
              onTapOutside: (event) => _focusNode.unfocus(),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _buildDecoration(bool isLoading) {
    const loadingIndicator = Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );

    final suffixIcon = _controller.text.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              context.cubit.clearPredictions();
            },
          )
        : null;

    return InputDecoration(
      hintText: 'Search for a place...',
      prefixIcon: const Icon(Icons.search),
      suffixIcon: isLoading ? loadingIndicator : suffixIcon,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }
}

extension _CubitX on BuildContext {
  PlacesSearchCubit get cubit => read<PlacesSearchCubit>();
}
