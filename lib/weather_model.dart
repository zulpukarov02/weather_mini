class Weather {
  final String name;
  final double temperature;
  final String mainCondition;
  Weather({
    required this.name,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json["name"],
      temperature: json["main"]["temp"].toDouble(),
      mainCondition: json["weather"][0]["main"],
    );
  }
}
