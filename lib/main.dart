import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_sandbox/models/User.dart';
import 'package:http/http.dart' as http;

import 'models/Album.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Album> futureAlbum;
  Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = getUsers();
  }

  Future<Album> fetchAlbumAsync() async {
    final response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/3'));
    if (response.statusCode < 400) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<User>> getUsers () async {
    final response = await http.get(Uri.http('localhost:7298', 'users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final users = <User>[];
      for(Map user in data) {
        users.add(User.fromJson(user));
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return FutureBuilder<List<User>>(future: futureUsers, builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      return Text("waka waka");
    });
  }
}

