import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Fonctions/FirestoreHelper.dart';
import 'package:messagerie_ipssi/View/AllConversations.dart';

class Connexion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConnexionState();
  }
}

class ConnexionState extends State<Connexion>{
  //Variable
  String mail ="";
  String password ="";

  //Fonctions

  Dialogue(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Votre adresse mail/ ou votre mot a été mal saisie"),
            actions: [

              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      )
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")
              ),
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
          //Bouton pour la connexion
          ElevatedButton(
              onPressed: (){
                // Se connecter
                FirestoreHelper().connect(mail, password).then((value){
                  setState(() {

                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return AllConversations();
                      }
                  ));
                }).catchError((error){
                  Dialogue();
                });
              },
              child: const Text("Connexion")
          )
        ],
      ),
    );
  }
}