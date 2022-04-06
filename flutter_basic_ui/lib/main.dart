import 'package:flutter/material.dart';
import 'package:flutter_basic_ui/app.dart';
import 'package:flutter_basic_ui/screens/screens.dart';
import 'package:flutter_basic_ui/theme.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.dark(),
        title: 'Chatter',
        builder: (context, child) {
          return StreamChatCore(client: client, child: child!);
        },
        home: HomeScreen());
  }
}
