import 'package:flutter_app/DictResultModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherRepo {



  Future<DictResult> getWeatherReport(String city) async {
    final result = await http.get('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=35fd4650d8e26d141085c1ae661f4646');
    print("inside future " + result.statusCode.toString());
    if (result.statusCode == 200) {
      final decodedJSON = json.decode(result.body);
      print(decodedJSON);
      final _data = DictResult.fromMap(decodedJSON);
      return _data;
    }else{

    }
  }


}