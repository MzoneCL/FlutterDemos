import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/theme_data_bloc.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
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
