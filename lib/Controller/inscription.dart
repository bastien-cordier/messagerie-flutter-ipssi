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
  Dialogue() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Votre inscription ne s'est pas effectuée"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }

  Widget bodyPage() {
    return Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.person), hintText: "Entrer votre prénom"),
            onChanged: (value) {
              setState(() {
                prenom = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.person), hintText: "Entrer votre nom"),
            onChanged: (value) {
              setState(() {
                nom = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.email), hintText: "Entrer votre mail"),
            onChanged: (value) {
              setState(() {
                mail = value;
              });
            },
          ),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
                icon: Icon(Icons.lock), hintText: "Entrer votre mot de passe"),
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () {
                // s'inscrire
                FirestoreHelper()
                    .register(prenom, nom, mail, password)
                    .then((value) {})
                    .catchError((error) {
                  Dialogue();
                });
              },
              child: const Text("Inscription"))
        ],
      ),
    );
  }
}
