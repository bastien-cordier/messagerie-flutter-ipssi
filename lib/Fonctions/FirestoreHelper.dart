import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messagerie_ipssi/Model/Message.dart';
import 'package:messagerie_ipssi/Model/Utilisateur.dart';

import 'package:messagerie_ipssi/Model/Conversation.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final fireUser = FirebaseFirestore.instance.collection("Utilisateurs");
  final fireMessage = FirebaseFirestore.instance.collection("Message");
  final fireConversation = FirebaseFirestore.instance.collection("Conversation");


  //Méthodes

  //Inscription un utilisateur
  Future <Utilisateur> register(String prenom , String nom , String mail , String password) async {
    UserCredential resultat = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    String uid = resultat.user!.uid;
    Map<String,dynamic> map = {
      "PRENOM":prenom,
      "NOM":nom,
      "MAIL": mail,
      "ISINSCRIPTION":DateTime.now(),
      "ISCONNECTED": true,
    };
    addUser(uid,map);
    return getProfil(uid);
  }

  //Connexion d'un utlisateur
  Future <Utilisateur> connect(String mail , String password) async {
    UserCredential resultat = await auth.signInWithEmailAndPassword(email: mail, password: password);
    String uid = resultat.user!.uid;
    return getProfil(uid);

  }

  //Fonction a pour de récupérer l'id de l'utisateur qui s'est connecté
  String getCurrentUserId(){
    return  auth.currentUser!.uid;
  }

  Future<Conversation> generateConversation(DocumentSnapshot snapshot) async {
      Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
      Conversation conversation = Conversation(snapshot);
      Utilisateur first = await FirestoreHelper().getProfil(map["FIRSTUSER"]);
      Utilisateur last = await FirestoreHelper().getProfil(map["SECONDUSER"]);
      Message lastMessage = await FirestoreHelper().getMessage(map["LASTMESSAGE"]);
      conversation.firstUser = first;
      conversation.secondUser = last;
      conversation.lastMessage = lastMessage;
      return conversation;
  }

  //Fonction a pour de construire une classe profil
  Future <Utilisateur> getProfil(String uid) async{
    DocumentSnapshot snapshot = await fireUser.doc(uid).get();
    return Utilisateur(snapshot);
  }

  //Fonction a pour de construire une classe profil
  Future <Message> getMessage(String uid) async{
    DocumentSnapshot snapshot = await fireMessage.doc(uid).get();
    return Message(snapshot);
  }

  // ajouter un utilisateur dans la base de donnée
  addUser(String uid , Map<String,dynamic>map){
    fireUser.doc(uid).set(map);
  }

  // mise à jour d'un utilisateur dans la base de donnée
  updateUser(String uid,Map<String,dynamic> map){
    fireUser.doc(uid).update(map);
  }

  // envoyer des messages
  sendMessage(String texte, Utilisateur user, Utilisateur moi){
    DateTime date = DateTime.now();
    Map <String, dynamic>map = {
      'from': moi.uid,
      'to': user.uid,
      'texte': texte,
      'envoieMessage': date
    };

    String idDate = date.microsecondsSinceEpoch.toString();

    addMessage(map, getMessageRef(moi.uid, user.uid, idDate));

    addConversation(getConversation(moi.uid, user, texte, date), moi.uid);

    addConversation(getConversation(moi.uid, moi, texte, date), user.uid);
  }

  Map<String, dynamic> getConversation(String sender, Utilisateur partenaire, String texte, DateTime date){
    Map<String, dynamic> map = partenaire.toMap();
    map['idmoi'] = sender;
    map['lastMessage'] = texte;
    map['envoieMessage'] = date;
    map['destinateur'] = partenaire.uid;

    return map;
  }

  String getMessageRef(String from, String to, String date){
    String resultat = "";
    List<String> liste = [from, to];
    liste.sort((a, b) => a.compareTo(b));
    for(var x in liste){
      resultat += x + "x";
    }
    resultat = resultat + date;
    return resultat;
  }

  addMessage(Map<String,dynamic> map,String uid){
    fireMessage.doc(uid).set(map);
  }
  addConversation(Map<String,dynamic> map,String uid){
    fireConversation.doc(uid).set(map);
  }
}