import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';
import 'package:messagerie_ipssi/View/AllConversations.dart';
import 'package:messagerie_ipssi/View/detailConversation.dart';

class NewConversations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewConversationsState();
  }
}

class NewConversationsState extends State<NewConversations> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: buildAppBar(),
        body: bodyPage()
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: false,
        backgroundColor:Color(0xFF2A5C86),
      title: Row(
        children: [
          BackButton(),
          SizedBox(width: 20.0 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mes contacts",
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fireUser.snapshots(),
        builder: (context, snapshot){
          // Pas d'information dans la collection Users
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          // Information dans la collection Users
          else
          {
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  Utilisateur users = Utilisateur(documents[index]);
                  if(users.uid == FirestoreHelper().getCurrentUserId()){
                    return Container();
                  }
                  else{
                    return Card(
                      elevation: 5.0,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text("${users.prenom} ${users.nom}"),
                        onTap: (){
                          checkConversation(users);
                        },
                      ),
                    );
                  }
                }
            );
          }
        }
    );
  }

  checkConversation(Utilisateur user) async {
    Navigator.pop(context);
    await FirestoreHelper().checkConversation(user);
  }
}
