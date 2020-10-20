import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  for (int i = 0; i < _data.length; i++) {
    print("Title ${_data[i]['title']}");
    print("Body: ${_data[i]['body']}");
  }

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse',
            style: new TextStyle(color: Colors.black, fontSize: 30.0)),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(14.5),
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: <Widget>[
                    new Divider(height: 5.5),
                    new ListTile(
                      title: Text(
                        "${_data[position]['title']}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 17.9),
                      ),
                      subtitle: Text("${_data[position]['body']}",
                          style: new TextStyle(
                              fontSize: 13.9,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic)),
                      leading: new CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Text(
                          "${_data[position]['id']}",
                          style: new TextStyle(
                              fontSize: 16.4, color: Colors.white),
                        ),
                      ),
                      onTap: () =>
                          _showonTapMessage(context, _data[position]['body']),
                    )
                  ],
                );
              })),
    ),
  ));
}

void _showonTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: Text(
      "Content",
      textAlign: TextAlign.center,
    ),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text(
          "OK",
          style: new TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
  // showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body); // returns a List type
}
