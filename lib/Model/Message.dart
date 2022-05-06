import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String idMessage = "";
  String from = "";
  String to = "";
  String texte = "";
  String conversionId = "";
  DateTime envoiMessage = DateTime.now();

  Message(DocumentSnapshot snapshot) {
    idMessage = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    from = map['FROM'];
    to = map['TO'];
    texte = map['TEXTE'];
    conversionId = map['CONVERSATION'];
    Timestamp timestamp = map["ENVOIE_MESSAGE"];
    envoiMessage = timestamp.toDate();
  }
}