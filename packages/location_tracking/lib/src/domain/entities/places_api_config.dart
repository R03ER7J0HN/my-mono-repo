class PlacesApiConfig {
  const PlacesApiConfig({
    required this.apiKey,
    required this.androidSha1Signature,
  });

  /// Google Places API key.
  final String apiKey;

  /// SHA-1 fingerprint of the Android signing certificate.
  /// Used for API key restriction verification.
  final String androidSha1Signature;
}
