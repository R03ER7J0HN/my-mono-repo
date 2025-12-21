import 'package:flutter/material.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';

class PredictionsDropdown extends StatelessWidget {
  const PredictionsDropdown({
    required this.predictions,
    required this.onPredictionSelected,
    super.key,
  });

  final List<PlacePredictionEntity> predictions;
  final ValueChanged<PlacePredictionEntity> onPredictionSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 250),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            final prediction = predictions[index];

            return _PredictionTile(
              prediction: prediction,
              onTap: () => onPredictionSelected(prediction),
            );
          },
        ),
      ),
    );
  }
}

class _PredictionTile extends StatelessWidget {
  const _PredictionTile({
    required this.prediction,
    required this.onTap,
  });

  final PlacePredictionEntity prediction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Text(
        prediction.mainText ?? prediction.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: prediction.secondaryText != null
          ? Text(
              prediction.secondaryText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      onTap: onTap,
    );
  }
}
