import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'to_do_item.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllerTitle;

  TextEditingController _controllerTime;

  TextEditingController _controllerDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerDetail = TextEditingController();
    _controllerTime = TextEditingController();
    _controllerTitle = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerTitle.dispose();
    _controllerTime.dispose();
    _controllerDetail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _controllerTitle,
                          decoration: InputDecoration(labelText: '标题'),
                        ),
                        TextField(
                          controller: _controllerDetail,
                          decoration: InputDecoration(labelText: '详情'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            /// 这里为了简单起见，时间就用当前时间了
                            _addItem(_controllerTitle.text, Timestamp.now(),
                                _controllerDetail.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('添加'),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

_delete(DocumentReference reference) {
  Firestore.instance.runTransaction((transaction) async {
    transaction.delete(reference);
  });
}

_addItem(String title, Timestamp time, String detail) {
  Firestore.instance
      .collection('to_do_list')
      .add({'title': title, 'time': time, 'detail': detail});
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('to_do_list').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> list) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                        content: new Text("Delete ?"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("NO"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text("YES"),
                            onPressed: () {
                              _delete(list[index].reference);
                              Navigator.of(context).pop();
                            },
                          )
                        ]));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    list[index].data['title'],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Divider(),
                  Text(list[index].data['detail']),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(list[index].data['time'].toDate().toString())
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
    itemCount: list.length,
  );
}
