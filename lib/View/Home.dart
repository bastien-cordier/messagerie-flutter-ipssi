
// import 'dart:html';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //Burger
      drawer: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
      ),

      ////

      body: Stack(
        children: [
          Center(
            child: bodyPage(),
          ),
        ],
      ),
    );
  }

  Widget bodyPage() {
    return Column(
      children: const [
        Text(
          "Bienvenue"
        ),

        


        //Bouton pour la connexion
        
      ],

    );
  }
}
