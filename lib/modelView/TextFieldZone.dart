import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';

class TextFieldZone extends StatefulWidget{
  TextFieldZone(Conversation this.conversation);
  Conversation conversation;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextFieldZoneState(conversation);
  }
}

class TextFieldZoneState extends State<TextFieldZone>{
  String text = "";
  TextFieldZoneState(Conversation this.conversation);
  Conversation conversation;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }

  Widget bodyPage() {
    Utilisateur? me;
    Utilisateur? other;
    if(FirestoreHelper().getCurrentUserId() == conversation.firstUser?.uid){
      me = conversation.firstUser;
      other = conversation.secondUser;
    } else {
      me = conversation.secondUser;
      other = conversation.firstUser;
    }
    var _controller = TextEditingController();

    return Row (
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Type message",
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  FirestoreHelper().sendMessage(_controller.text, other, me, conversation);
                  _controller.clear;
                },
                icon: Icon(
                    Icons.send,
                  color: Color(0xFF4CAF50),
                )
              ),
            ),
          )
        ),
      ],
    );
  }
}