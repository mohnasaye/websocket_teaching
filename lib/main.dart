import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home()
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late IO.Socket socket;
  initSocket(){
    socket = IO.io("http://localhost:4000/contracts",
      <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        //ToDo: Implement Token
      },);
    socket.connect();
    socket.onConnect((data) => {
      debugPrint("Success")
    });
    socket.onConnectError((err) {
      print('Connection Error: $err');
    });


    socket.emit("message", {
      "name": "Yousef Abdeen"
    });

    socket.on("error", (data) => {
      debugPrint(data["message"])
    });
    socket.on("message", (data) => {
      debugPrint(data["body"])
    });
  }

  @override
  void initState() {
    initSocket();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket Io"),
      ),
    );
  }
}
