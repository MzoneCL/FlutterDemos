import 'package:flutter/material.dart';

import 'weather.dart';

class WeatherWidget extends StatelessWidget {
  Weather _weather;
  List<Forecast> _listForecast;

  WeatherWidget(this._weather) {
    _listForecast = _weather.data.forecast;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(_weather.data.city, style: TextStyle(fontSize: 30),),
                Text(_listForecast[0].type),
              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              SizedBox(height: 8.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_weather.data.wendu + '℃', style: TextStyle(fontSize: 30),),
                  Text(_listForecast[0].low.replaceAll('低温 ', '') + ' - ' + _listForecast[0].high.replaceAll('高温 ', ''))
                ],
              ),SizedBox(height: 8.0),
              Text('风向：' + _listForecast[0].fengxiang),SizedBox(height: 8.0),
              Text('风力：' + _listForecast[0].fengli.replaceAll('<![CDATA[', '').replaceAll(']]>', '')),SizedBox(height: 8.0),
              Text('提示：' + _weather.data.ganmao),
              SizedBox(height: 8.0),Divider(),SizedBox(height: 8.0),


              Row(children: <Widget>[
                Text('昨天：' + _weather.data.yesterday.type),
                Text(_weather.data.yesterday.low.replaceAll('低温 ', '') + ' - ' + _weather.data.yesterday.high.replaceAll('高温 ', ''))
              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              SizedBox(height: 8.0),
              Row(children: <Widget>[
                Text('明天：' + _listForecast[1].type),
                Text(_listForecast[1].low.replaceAll('低温 ', '') + ' - ' + _listForecast[1].high.replaceAll('高温 ', ''))
              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              SizedBox(height: 8.0),
              Row(children: <Widget>[
                Text('后天：' + _listForecast[2].type),
                Text(_listForecast[2].low.replaceAll('低温 ', '') + ' - ' + _listForecast[2].high.replaceAll('高温 ', ''))
              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              SizedBox(height: 8.0),

            ],
          ),
        ),
      ),
    );
  }
}