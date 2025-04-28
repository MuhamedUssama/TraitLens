class EndPoints {
  static const String host = '192.168.1.3';

  static const String textBaseUrl = 'http://$host:8000';
  static const String audioBaseUrl = 'http://$host:5001';
  static const String imageBaseUrl = 'http://$host:5002';

  static const String textEndPoint = '$textBaseUrl/analyze_personality';
  static const String audioEndPoint = '$audioBaseUrl/predictAudio';
  static const String imageEndPoint = '$imageBaseUrl/predict';
}
