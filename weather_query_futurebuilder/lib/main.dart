import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'weather.dart';
import 'weather_widget.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(theme: ThemeData.dark(), home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _cityName;

  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cityName = '绵阳';
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止键盘弹起时，出现边界溢出的情况
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration:
              InputDecoration(hintText: "输入城市名", border: InputBorder.none),
          textInputAction: TextInputAction.search,
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              _cityName = text;
            });
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  _cityName = _controller.text;
                });
              })
        ],
      ),
      body: FutureBuilder(
          future: fetchWeatherByCityName('$_cityName'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather weather = snapshot.data;
              return WeatherWidget(weather);
            } else if (snapshot.hasError) {
              return Text("请确保城市名输入正确！");
            }
            return Center(child: new CircularProgressIndicator());
          }),
    );
  }

  Future<Weather> fetchWeatherByCityName(String city) async {
    BaseOptions options = BaseOptions(
      receiveTimeout: 5000,
      connectTimeout: 5000,
    );
    Dio dio = Dio(options);

    Response response =
        await dio.get('https://www.apiopen.top/weatherApi?city=$city');
    print(response);
    if (response.data["code"] != 200) {
      throw "error";
    }

    return Weather.fromJson(json.decode(response.toString()));
  }
}
