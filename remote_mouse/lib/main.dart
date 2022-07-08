import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Socket socket;
  @override
  void initState() {
    super.initState();
    startConnection();
  }

  void startConnection() async {
    socket = await Socket.connect('192.168.0.19', 1305);
    socket.setOption(SocketOption.tcpNoDelay, true);
  }

  void closeConnection() {
    socket.close();
  }

  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            onPanDown: (details) {
              // socket.add(utf8.encode("pan down"));
            },
            onPanUpdate: (details) {
              int senstivity = 2;
              var x = senstivity * details.delta.dx.round();
              var y = senstivity * details.delta.dy.round();
              if (x != 0 || y != 0) {
                socket.add(utf8.encode("$x,$y,"));
              }
            },
            child: Container(
              color: Colors.white,
            ),
          )),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  height: 60,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey,
                  height: 60,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
