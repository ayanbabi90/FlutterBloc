// To parse this JSON data, do
//
//     final dictResult = dictResultFromMap(jsonString);

import 'dart:convert';

DictResult dictResultFromMap(String str) => DictResult.fromMap(json.decode(str));

String dictResultToMap(DictResult data) => json.encode(data.toMap());

class DictResult {
  DictResult({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Rain rain;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory DictResult.fromMap(Map<String, dynamic> json) => DictResult(
    coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
    weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
    base: json["base"] == null ? null : json["base"],
    main: json["main"] == null ? null : Main.fromMap(json["main"]),
    visibility: json["visibility"] == null ? null : json["visibility"],
    wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
    rain: json["rain"] == null ? null : Rain.fromMap(json["rain"]),
    clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
    dt: json["dt"] == null ? null : json["dt"],
    sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
    timezone: json["timezone"] == null ? null : json["timezone"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    cod: json["cod"] == null ? null : json["cod"],
  );

  Map<String, dynamic> toMap() => {
    "coord": coord == null ? null : coord.toMap(),
    "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toMap())),
    "base": base == null ? null : base,
    "main": main == null ? null : main.toMap(),
    "visibility": visibility == null ? null : visibility,
    "wind": wind == null ? null : wind.toMap(),
    "rain": rain == null ? null : rain.toMap(),
    "clouds": clouds == null ? null : clouds.toMap(),
    "dt": dt == null ? null : dt,
    "sys": sys == null ? null : sys.toMap(),
    "timezone": timezone == null ? null : timezone,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "cod": cod == null ? null : cod,
  };

}

class Clouds {
  Clouds({
    this.all,
  });

  int all;

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
    all: json["all"] == null ? null : json["all"],
  );

  Map<String, dynamic> toMap() => {
    "all": all == null ? null : all,
  };
}

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "lon": lon == null ? null : lon,
    "lat": lat == null ? null : lat,
  };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  factory Main.fromMap(Map<String, dynamic> json) => Main(
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
    tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"],
    humidity: json["humidity"] == null ? null : json["humidity"],
    seaLevel: json["sea_level"] == null ? null : json["sea_level"],
    grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
  );

  Map<String, dynamic> toMap() => {
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "temp_min": tempMin == null ? null : tempMin,
    "temp_max": tempMax == null ? null : tempMax,
    "pressure": pressure == null ? null : pressure,
    "humidity": humidity == null ? null : humidity,
    "sea_level": seaLevel == null ? null : seaLevel,
    "grnd_level": grndLevel == null ? null : grndLevel,
  };
}

class Rain {
  Rain({
    this.the1H,
  });

  double the1H;

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
    the1H: json["1h"] == null ? null : json["1h"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "1h": the1H == null ? null : the1H,
  };
}

class Sys {
  Sys({
    this.country,
    this.sunrise,
    this.sunset,
  });

  String country;
  int sunrise;
  int sunset;

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
    country: json["country"] == null ? null : json["country"],
    sunrise: json["sunrise"] == null ? null : json["sunrise"],
    sunset: json["sunset"] == null ? null : json["sunset"],
  );

  Map<String, dynamic> toMap() => {
    "country": country == null ? null : country,
    "sunrise": sunrise == null ? null : sunrise,
    "sunset": sunset == null ? null : sunset,
  };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : json["main"],
    description: json["description"] == null ? null : json["description"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "main": main == null ? null : main,
    "description": description == null ? null : description,
    "icon": icon == null ? null : icon,
  };
}

class Wind {
  Wind({
    this.speed,
    this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
    speed: json["speed"] == null ? null : json["speed"].toDouble(),
    deg: json["deg"] == null ? null : json["deg"],
  );

  Map<String, dynamic> toMap() => {
    "speed": speed == null ? null : speed,
    "deg": deg == null ? null : deg,
  };
}
