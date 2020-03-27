import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.redAccent[400]);


void main() {
  runApp(FriendlyChatApp());
}
// root stateless
class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _messages = <ChatMessage>[];
  final _textController = TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FriendlyChat'),
        elevation:
            Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0),
    Container(
    margin: const EdgeInsets.only(bottom: 16.0),
    decoration: BoxDecoration(color: Theme.of(context).cardColor),
    child: _buildTextComposer(),
    ),
    ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey[200]),
              ),
          )
        : null),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: kIOSTheme.accentColor), // Change TextComposer Part #1 regardless platform, Icon theme will be used with kIOStheme.
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) => setState(() => _isComposing = text.length > 0),
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            IconButton( // Change TextComposer Part #2 Change the icon of IconButton
              icon: _isComposing ? Icon(Icons.directions_run) : Icon(Icons.directions_walk), // Inactive: direction_walk, activeL direction_run
              onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null, // _isComposing이 false이면 onPressed 인수를 null로 변경
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() => _isComposing = false);
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 3000), // Message #1 Slow down the speed at which sent text appears
        vsync: this,
      ),
    );
    setState(() => _messages.insert(0, message));
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;
  final _name = "Jeon, Yeo Hun";

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Message #2 Change the profile and text order of the message list.
            Expanded( // 줄바꿈
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_name, style: Theme.of(context).textTheme.subhead), //메세지 넣
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}