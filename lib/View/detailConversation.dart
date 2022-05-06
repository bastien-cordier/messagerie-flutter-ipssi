import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/Model/Message.dart';
import 'package:messagerie_ipssi/Model/MessageBubble.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';
import 'package:messagerie_ipssi/modelView/ConversationChamps.dart';



class detailConversation extends StatelessWidget {

  Conversation conversation;
  detailConversation({required Conversation this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: body(context),
    );
  }

  AppBar buildAppBar() {
    String? title = conversation.firstUser?.uid != FirestoreHelper().getCurrentUserId() ? conversation.firstUser?.prenom : conversation.secondUser?.prenom;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/user_2.png"),
          // ),
          SizedBox(width: 20.0 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title == null ? "None" : title,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fireMessage.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List documents = SortMessage(snapshot.data!.docs);

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Message message = Message(documents[index]);
                      if (message.conversionId != conversation.uid) {
                        return Container();
                      }
                      return MessageBubble(
                          me: FirestoreHelper().getCurrentUserId(),
                          message: message);
                    }
                  ),
                ),
              ),
              ConversationChamps(conversation),
            ],
          );
        }
    );
  }

  SortMessage(messages){
    if(messages == null) {
      return [];
    }

    messages.sort((a, b) {
      Message messageA = Message(a);
      Message messageB = Message(b);
      return messageA.envoiMessage.compareTo(messageB.envoiMessage);
    });
    return messages;
  }
}
