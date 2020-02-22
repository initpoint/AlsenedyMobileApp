import 'dart:async';

import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/chat.dart';
import 'package:ecommerce_app_ui_kit/src/models/conversation.dart';
import 'package:ecommerce_app_ui_kit/src/models/message.model.dart';
import 'package:ecommerce_app_ui_kit/src/models/user.dart';
import 'package:ecommerce_app_ui_kit/src/services/chat.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ChatMessageListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ConversationsList _conversationList = new ConversationsList();
  User _currentUser = new User.init().getCurrentUser();
  final _myListKey = GlobalKey<AnimatedListState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageService = Provider.of<BaseChatService>(context);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FutureBuilder(
              future: messageService.getMyChat(),
              builder: (context,AsyncSnapshot<List<Message>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: AnimatedList(
                      key: _myListKey,
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      initialItemCount:
                          snapshot.data.length,
                      itemBuilder:
                          (context, index, Animation<double> animation) {
                        Message message = snapshot.data[index];
                        return ChatMessageListItem(
                          message: message,
                          animation: animation,
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.10),
                    offset: Offset(0, -4),
                    blurRadius: 10)
              ],
            ),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Chat text here',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.8)),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () {
                    setState(() {
                      _conversationList.conversations[0].chats.insert(
                          0,
                          new Chat(
                              myController.text, '21min ago', _currentUser));
                      _myListKey.currentState.insertItem(0);
                    });
                    Timer(Duration(milliseconds: 100), () {
                      myController.clear();
                    });
                  },
                  icon: Icon(
                    UiIcons.cursor,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
