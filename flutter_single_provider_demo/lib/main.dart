import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/data_info.dart';
import 'page2.dart';

/// 使用 Consumer

void main() => runApp(
    ChangeNotifierProvider(builder: (context) => DataInfo(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataInfo>(
      builder: (context, dataInfo, _) => MaterialApp(
        home: MyHomePage(),
        theme: dataInfo.themeData,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
      ),
      body: Consumer<DataInfo>(
        builder: (context, dataInfo, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dataInfo.addCount();
                    }),
                Chip(
                  label: Text(
                    dataInfo.count.toString(),
                    style: TextStyle(fontSize: 30.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                ),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      dataInfo.subCount();
                    }),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Page2()));
                  },
                  child: Text('Page 2'),
                )
              ],
            )),
      ),
      floatingActionButton: Consumer<DataInfo>(
        builder: (context, dataInfo, _) => FloatingActionButton(
          onPressed: () {
            dataInfo.changeTheme();
          },
          child: Icon(
            Icons.build,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}