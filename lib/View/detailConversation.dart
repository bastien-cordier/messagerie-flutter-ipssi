import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';

class detailConversation extends StatefulWidget{
  Conversation conversation;
  detailConversation({required this.conversation});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailConversationState();
  }
}


class detailConversationState extends State<detailConversation>{
  @override
  void initState()  {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Card(
          elevation: 5.0,
          color: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const ListTile(
            //Image
            // leading: ImageRond(image: users.image,size:60),
            title: Text("YO"),
            // subtitle: Text("${users.mail}"),
          ),
          
        ),
        Flexible(
          child: ZoneText(
            text: "Yo",
          ),),
      ],
    );
  }
}

