import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur{
  late String _uid;
  late String nom;
  late String prenom;
  late String avatar;
  DateTime? dateNaissance;
  late String mail;
  late DateTime isInscription;
  late bool isConnected;

  //Constructeur
  Utilisateur(DocumentSnapshot snapshot){
    _uid = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    Timestamp timestamp = map["ISINSCRIPTION"];
    isInscription = timestamp.toDate();
    isConnected = map["ISCONNECTED"];
    prenom = map["PRENOM"];
    nom = map["NOM"];
    avatar = map["AVATAR"];
    mail = map["MAIL"];
  }


  String get uid {
    return _uid;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map;
    return map={
      'NOM': nom,
      'PRENOM': prenom,
      'IMAGE': avatar,
      'MAIL': mail,
      'NAISSANCE': dateNaissance
    };
  }
}
