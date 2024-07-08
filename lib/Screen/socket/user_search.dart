import 'dart:async';
import 'dart:convert';

import 'package:barberside/Screen/socket/socket_dto.dart';
import 'package:flutter/material.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';

class ChatPage extends StatefulWidget {
  final int id;

  ChatPage(this.id);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late StompClient stompClient;
  List<MessageData> msglist = [];
  List<SocketDto> socketDtoList = [];
  TextEditingController msgtext = TextEditingController();
  bool connected = false;

  @override
  void initState() {
    super.initState();

    // Initialize the StompClient
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://192.168.18.3:8080/ws', // Ensure this URL is correct
        onConnect: onConnect,
        beforeConnect: () async {
          print('Waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('Connecting...');
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket error: $error');
        },
        onStompError: (dynamic error) {
          print('STOMP error: $error');
        },
        onDisconnect: (frame) {
          print('Disconnected: ${frame.body}');
          setState(() {
            connected = false;
          });
        },
        // onConnectError: (dynamic error) {
        //   print('Connect error: $error');
        // },
        // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );

    // Activate the StompClient
    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    setState(() {
      connected = true;
    });

    stompClient.subscribe(
      destination: '/topic/barber/${widget.id}',
      callback: (frame) {
        if (frame.body != null) {
          Map<String, dynamic> result = json.decode(frame.body!);
          print(result);

          setState(() {
            SocketDto socketDto = SocketDto();
            socketDto.customerId = result['customerId'];
            socketDto.latitude = result['latitude'];
            socketDto.longitude = result['longitude'];
            socketDtoList.add(socketDto);
          });
        }
      },
    );

    // This is just for testing purposes
    // Timer.periodic(const Duration(seconds: 5), (_) {
    //   stompClient.send(
    //     destination: '/topic/receive/${widget.id}',
    //     body: json.encode({'from': 'myid', 'text': 'Hello!'}),
    //   );
    // });
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.id}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: socketDtoList.length,
              itemBuilder: (context, index) {
                final msg = socketDtoList[index];
                return Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Do you accept the terms and conditions?',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle accept action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // text color
                            ),
                            child: Text('Accept'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle decline action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red, // text color
                            ),
                            child: Text('Decline'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (connected)
            if (!connected)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Disconnected from WebSocket'),
              ),
        ],
      ),
    );
  }
}

class MessageData {
  String msgtext, userid;
  bool isme;

  MessageData({
    required this.msgtext,
    required this.userid,
    required this.isme,
  });
}
