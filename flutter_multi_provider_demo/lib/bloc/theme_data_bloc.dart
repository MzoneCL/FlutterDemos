import 'dart:async';
import 'package:flutter/material.dart';

class ThemeDataBloc {
  StreamController<ThemeData> _streamController;
  Stream<ThemeData> _stream;
  ThemeData _themeData;

  ThemeDataBloc() {
    _themeData = ThemeData.light();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  Stream<ThemeData> get stream => _stream;

  changeTheme() {
    _themeData = _themeData == ThemeData.light()?ThemeData.dark():ThemeData.light();
    _streamController.sink.add(_themeData);
  }
  dispose() {
    _streamController.close();
  }
}
