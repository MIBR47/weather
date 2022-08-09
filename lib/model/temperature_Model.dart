// ignore_for_file: file_names

class TemperatureModel {
  double? temperature;
  double? feelsLike;
  int? pressure;
  int? humidity;

  TemperatureModel({
    this.temperature,
    this.feelsLike,
    this.pressure,
    this.humidity,
  });

  TemperatureModel.fromJson(Map<String, dynamic> json) {
    temperature = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temperature,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity
    };
  }
}
