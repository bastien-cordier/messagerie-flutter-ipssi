import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Model/Message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.me,
    required this.message,
  }) : super(key: key);

  final Message message;
  final String me;

  @override
  Widget build(BuildContext context) {
    bool isSender = message.from == me;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment:
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          MessageText(context, isSender)
        ],
      ),
    );
  }

  Widget MessageText(BuildContext context, isSender){
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0 * 0.75,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF33B5FF).withOpacity(isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.texte,
        style: TextStyle(
          color: isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}
