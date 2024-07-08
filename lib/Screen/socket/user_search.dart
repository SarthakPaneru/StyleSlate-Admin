import 'dart:async';
import 'dart:convert';

import 'package:barberside/Screen/socket/socket_dto.dart';
import 'package:barberside/config/app_constants.dart';
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
        url: 'ws://${ApiConstants.address}/ws', // Ensure this URL is correct
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
                return ListTile(
                  title: Text('${msg.customerId}'),
                  subtitle: Text('${msg.longitude} and ${msg.latitude}'),
                  // trailing: msg.isme ? Icon(Icons.person) : null,
                );
              },
            ),
          ),
          if (connected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgtext,
                      decoration:
                          const InputDecoration(labelText: 'Send a message'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (msgtext.text.isNotEmpty) {
                        print(msgtext.text);
                        stompClient.send(
                          destination: '/app/barber/${widget.id}',
                          body: json
                              .encode({'from': 'myid', 'text': msgtext.text}),
                        );
                        msgtext.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
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
