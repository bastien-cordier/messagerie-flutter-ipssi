import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';

class Inscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InscriptionState();
  }

}

class InscriptionState extends State<Inscription> {
  //variables
  String prenom = "";
  String nom = "";
  String mail = "";
  String password = "";

  //Fonctions
   Dialogue(){
     showDialog(
          barrierDismissible: false,
         context: context,
         builder: (context){
           return AlertDialog(
             title: const Text("Erreur"),
             content: const Text("Votre inscription ne s'est pas effectuée"),
             actions: [
               ElevatedButton(
                   onPressed: (){
                     Navigator.pop(context);
                   },
                   child: const Text("Ok")
               )
             ],
           );
         }
     );
   }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }



  Widget bodyPage(){
    return Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
           TextField(
             decoration: const InputDecoration(
               hintText: "Entrer votre prénom"
             ),
            onChanged: (value){
               setState(() {
                 prenom = value;
               });
            },
           ),
          TextField(
            decoration: const InputDecoration(
                hintText: "Entrer votre nom"
            ),
            onChanged: (value){
              setState(() {
                nom = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
                hintText: "Entrer votre mail"
            ),
            onChanged: (value){
              setState(() {
                mail = value;
              });
            },
          ),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Entrer votre mot de passe"
            ),
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // s'inscrire
                FirestoreHelper().register(prenom, nom, mail, password).then((value){

                }).catchError((error){
                  Dialogue();
                });
              },
              child: const Text("Inscription")
          )
        ],
      )
    );
  }
}