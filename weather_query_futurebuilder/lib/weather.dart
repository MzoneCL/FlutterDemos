import 'dart:convert' show json;

class Weather {
  int code;
  String msg;
  WeatherData data;

  Weather.fromParams({this.code, this.msg, this.data});

  factory Weather(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Weather.fromJson(json.decode(jsonStr)) : new Weather.fromJson(jsonStr);

  Weather.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new WeatherData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class WeatherData {

  Object aqi;
  String city;
  String ganmao;
  String wendu;
  List<Forecast> forecast;
  Yesterday yesterday;

  WeatherData.fromParams({this.aqi, this.city, this.ganmao, this.wendu, this.forecast, this.yesterday});

  WeatherData.fromJson(jsonRes) {
    aqi = jsonRes['aqi'];
    city = jsonRes['city'];
    ganmao = jsonRes['ganmao'];
    wendu = jsonRes['wendu'];
    forecast = jsonRes['forecast'] == null ? null : [];

    for (var forecastItem in forecast == null ? [] : jsonRes['forecast']){
      forecast.add(forecastItem == null ? null : new Forecast.fromJson(forecastItem));
    }

    yesterday = jsonRes['yesterday'] == null ? null : new Yesterday.fromJson(jsonRes['yesterday']);
  }

  @override
  String toString() {
    return '{"aqi": $aqi,"city": ${city != null?'${json.encode(city)}':'null'},"ganmao": ${ganmao != null?'${json.encode(ganmao)}':'null'},"wendu": ${wendu != null?'${json.encode(wendu)}':'null'},"forecast": $forecast,"yesterday": $yesterday}';
  }
}

class Yesterday {

  String date;
  String fl;
  String fx;
  String high;
  String low;
  String type;

  Yesterday.fromParams({this.date, this.fl, this.fx, this.high, this.low, this.type});

  Yesterday.fromJson(jsonRes) {
    date = jsonRes['date'];
    fl = jsonRes['fl'];
    fx = jsonRes['fx'];
    high = jsonRes['high'];
    low = jsonRes['low'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"date": ${date != null?'${json.encode(date)}':'null'},"fl": ${fl != null?'${json.encode(fl)}':'null'},"fx": ${fx != null?'${json.encode(fx)}':'null'},"high": ${high != null?'${json.encode(high)}':'null'},"low": ${low != null?'${json.encode(low)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'}}';
  }
}

class Forecast {

  String date;
  String fengli;
  String fengxiang;
  String high;
  String low;
  String type;

  Forecast.fromParams({this.date, this.fengli, this.fengxiang, this.high, this.low, this.type});

  Forecast.fromJson(jsonRes) {
    date = jsonRes['date'];
    fengli = jsonRes['fengli'];
    fengxiang = jsonRes['fengxiang'];
    high = jsonRes['high'];
    low = jsonRes['low'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"date": ${date != null?'${json.encode(date)}':'null'},"fengli": ${fengli != null?'${json.encode(fengli)}':'null'},"fengxiang": ${fengxiang != null?'${json.encode(fengxiang)}':'null'},"high": ${high != null?'${json.encode(high)}':'null'},"low": ${low != null?'${json.encode(low)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'}}';
  }
}

