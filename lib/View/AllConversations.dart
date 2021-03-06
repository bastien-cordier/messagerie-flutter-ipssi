import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/Model/Message.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';
import 'package:messagerie_ipssi/View/NewConversations.dart';
import 'package:messagerie_ipssi/View/detailConversation.dart';

import '../Fonctions/FirestoreHelper.dart';


class AllConversations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllConversationsState();
  }
}

class AllConversationsState extends State<AllConversations>{
  late Stream<List<Conversation>> conversationsStream;
  @override
  void initState()  {
    conversationsStream = FirestoreHelper()
        .fireConversation
        .snapshots()
        .asyncMap((conversations) => Future.wait([
          for (var conversation in conversations.docs)
            FirestoreHelper().generateConversation(conversation)
    ]));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AllConversations oldWidget) {
    conversationsStream = FirestoreHelper()
        .fireConversation
        .snapshots()
        .asyncMap((conversations) => Future.wait([
          for (var conversation in conversations.docs)
            FirestoreHelper().generateConversation(conversation)
    ]));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(),
      body: bodyPage(),
      floatingActionButton: buildFloatingActionButton()
    );
  }

  FloatingActionButton buildFloatingActionButton(){
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return NewConversations();
            }
        ));
      },
      label: const Icon(Icons.add),
      backgroundColor: Colors.red,
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SizedBox(width: 20.0 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mes messages",
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return StreamBuilder<List<Conversation>>(
      stream: conversationsStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        List documents = snapshot.data!;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context,index){
            String title = documents[index].firstUser.uid == FirestoreHelper().getCurrentUserId() ? documents[index].secondUser.prenom : documents[index].firstUser.prenom;
            if(documents[index].firstUser == null || documents[index].secondUser == null){
              return Container();
            }
            if(![documents[index].firstUser.uid, documents[index].secondUser.uid].contains(FirestoreHelper().getCurrentUserId())){
              return Container();
            }
            return buildConversationCard(documents[index], title);
          }
        );
      }
    );
  }

  Card buildConversationCard(Conversation conversation, String title){
    return Card(
      elevation: 5.0,
      color: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return detailConversation(conversation: conversation);
              }
          ));
        },
        title: Text(title),
      ),
    );
  }
}