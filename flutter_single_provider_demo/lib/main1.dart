import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/data_info.dart';


/// 使用 Provider.of(context) 获取 DataInfo

/*void main() => runApp(
    ChangeNotifierProvider(builder: (context) => DataInfo(), child: MyApp()));
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    return MaterialApp(
      home: MyHomePage(),
      theme: dataInfo.themeData,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
      ),
      body: Center(
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
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataInfo.changeTheme();
        },
        child: Icon(
          Icons.build,
          color: Colors.white,
        ),
      ),
    );
  }
}