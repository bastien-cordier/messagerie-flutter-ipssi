import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messagerie_ipssi/Model/Message.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';

import '../Fonctions/FirestoreHelper.dart';

class Conversation {
    late String _uid;
    Message? lastMessage;
    Utilisateur? firstUser;
    Utilisateur? secondUser;

    String get uid {
        return _uid;
    }

    Conversation(DocumentSnapshot snapshot){
        _uid = snapshot.id;
    }

    Map<String, dynamic> toMap(){
        Map<String, dynamic> map;
        return map={
            'LASTMESSAGE': lastMessage,
        };
    }
}