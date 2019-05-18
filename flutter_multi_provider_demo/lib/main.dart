import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/theme_data_bloc.dart';
import 'page2.dart';


main() {
  var counterBloc = CounterBloc();
  var themeDataBloc = ThemeDataBloc();
  runApp(MultiProvider(providers: [
    Provider<CounterBloc>.value(value: counterBloc),
    Provider<ThemeDataBloc>.value(value: themeDataBloc),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return MaterialApp(
          home: MyHomePage(),
          theme: snapshot.data,
        );
      },
      initialData: ThemeData.light(),
      stream: Provider.of<ThemeDataBloc>(context).stream,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Provider Demo'),
      ),
      body: Center(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<CounterBloc>(context).addCounter();
                    }),
                Chip(
                  padding: EdgeInsets.all(12.0),
                  label: Text(
                    snapshot.data.toString(),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Provider.of<CounterBloc>(context).subCounter();
                    }),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Page2()));
                  },
                  child: Text('Page 2'),
                )
              ],
            );
          },
          initialData: Provider.of<CounterBloc>(context).count,
          stream: Provider.of<CounterBloc>(context).stream,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeDataBloc>(context).changeTheme();
        },
        child: Icon(
          Icons.build,
          color: Colors.white,
        ),
      ),
    );
  }
}
