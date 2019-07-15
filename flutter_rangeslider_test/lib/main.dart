import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RangeValues values = RangeValues(0, 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("RangeSlider"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RangeSlider(
              values: values,
              onChanged: (change) {
                setState(() {
                  values = change;
                  print(change);
                });
              },
              min: 0,
              max: 10.0,
              divisions: 10,
              labels: RangeLabels("${values.start}", "${values.end}"),
              activeColor: Colors.red,
              inactiveColor: Colors.grey[100],
            ),
            Text("${values.end}"),

            SizedBox(height: 30,),

            RaisedButton(
                child: Text("Show SnackBar"),
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("This is a snackbar."),
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    elevation: 100,
                    action: SnackBarAction(label: "OK", onPressed: (){}, textColor: Colors.green,),
                  ));
                })
          ],
        ),
      ),
    );
  }
}
