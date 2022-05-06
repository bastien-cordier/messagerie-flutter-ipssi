import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messagerie_ipssi/Model/MessageBubble.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';
import 'package:messagerie_ipssi/Model/Message.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';

class MessageController extends StatefulWidget{
  Utilisateur id;
  Utilisateur idPartner;
  MessageController(@required Utilisateur this.id,@required Utilisateur this.idPartner);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessageControllerState();
  }
}

class MessageControllerState extends State<MessageController>{
  late Animation animation;
  late AnimationController controller;

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fireMessage.orderBy('envoiMessage',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {          
          if (!snapshot.hasData) {            
            return const CircularProgressIndicator();
          }          
          else {            
            List<DocumentSnapshot>documents = snapshot.data!.docs;            
            return ListView.builder(                
                itemCount: documents.length,                
                itemBuilder: (BuildContext ctx,int index)                
                {                  
                  Message discussion = Message(documents[index]);                  
                  if((discussion.from==widget.id && discussion.to==widget.idPartner.uid)
                      ||(discussion.from==widget.idPartner.uid
                          &&discussion.to==widget.id.uid)
                  ) {
                    return MessageBubble(widget.id.uid, widget.idPartner, discussion,);
                  }                      
                  return Container();      
                }            
                );          
          }        
        }    
        );  
  }
}