import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';
import 'package:messagerie_ipssi/modelView/TextFieldZone.dart';

class ConversationChamps extends StatelessWidget {

  ConversationChamps(Conversation this.conversation);
  Conversation conversation;

  @override
  Widget build(BuildContext context) {
    String text = "";
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0 * 0.75,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextFieldZone(conversation)
                ),
              ),
            ],
          )
        ),
      );
  }
}