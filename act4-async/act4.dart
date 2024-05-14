import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  try {
    // Fetch data from API
    HttpClient client = HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m&timezone=auto'));
    HttpClientResponse response = await request.close();
    String data = await response.transform(utf8.decoder).join();

    // Parse response
    Map<String, dynamic> jsonData = json.decode(data);
    WeatherResponse weatherResponse = WeatherResponse.fromJson(jsonData);

    // Example processing
    print("longitude: ${weatherResponse.longitude}");
    print("latitude: ${weatherResponse.latitude}");
    print('Weather: ${weatherResponse.current['temperature_2m']}°C');
  } catch (e) {
    print('Error: $e');
  }
}

class WeatherResponse {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final dynamic utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final dynamic elevation;
  final Map<String, dynamic> currentUnits;
  final Map<String, dynamic> current;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentUnits: json['current_units'],
      current: json['current'],
    );
  }
}
