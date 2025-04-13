class EndPoints {
  static const String textBaseUrl = 'http://192.168.1.4:5001';
  static const String audioBaseUrl = 'http://192.168.1.4:5000';

  static const String textEndPoint = '$textBaseUrl/analyze';
  static const String imageEndPoint = '/predict';
  static const String audioEndPoint = '$audioBaseUrl/predictAudio';
}
