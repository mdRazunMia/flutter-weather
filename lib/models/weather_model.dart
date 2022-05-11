class Weather {
  double? temparature;
  String? location;
  double? feels_like;
  int? humidity;
  int? pressure;
  double? wind;
  String? icon;
  String? description;
  double? max;
  double? min;

  Weather(
      {this.temparature,
      this.location,
      this.feels_like,
      this.humidity,
      this.pressure,
      this.wind,
      this.icon,
      this.description,
      this.max,
      this.min});

  Weather.fromJson(Map<String, dynamic> json) {
    temparature = json["main"]["temp"];
    location = json["name"];
    feels_like = json["main"]["feels_like"];
    humidity = json["main"]["humidity"];
    pressure = json["main"]["pressure"];
    wind = json["wind"]["speed"];
    icon = json["weather"][0]["icon"];
    description = json["weather"][0]["description"];
    max = json["main"]["temp_max"];
    min = json["main"]["temp_min"];
  }
}
