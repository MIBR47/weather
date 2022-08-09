// ignore_for_file: file_names

class MainWeatherModel {
  int? id;
  String? mainWeather;
  String? description;

  MainWeatherModel({
    this.mainWeather,
    this.description,
  });

  MainWeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainWeather = json['main'];
    description = json['description'].toString().toUpperCase();
  }

  Map<String, dynamic> toJson() {
    return {
      'main': mainWeather,
      'description': description,
      'id': id,
    };
  }
}
