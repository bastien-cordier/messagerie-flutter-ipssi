import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messagerie_ipssi/Controller/connexion.dart';
import 'package:messagerie_ipssi/Controller/inscription.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if ((defaultTargetPlatform == TargetPlatform.iOS) || (defaultTargetPlatform == TargetPlatform.android)){
    await Firebase.initializeApp();
  }
  else
  {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCDnj0hLTn-07p9HyZsTv53gEgJLLlNVt0",
            authDomain: "ipssi-messagerie.firebaseapp.com",
            projectId: "ipssi-messagerie",
            storageBucket: "ipssi-messagerie.appspot.com",
            messagingSenderId: "505804800647",
            appId: "1:505804800647:web:ec819357305d7b3991ee22"
        )
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Variable
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bodyPage(),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // pas le temps d'implementer la création d'une conversation

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text("Inscription"),
        //     Switch(
        //         value: selected,
        //         onChanged: (value) {
        //           setState(() {
        //             selected = value;
        //           });
        //         }),
        //     const Text("Connexion"),
        //   ],
        // ),
        // (selected) ? Connexion() : Inscription(),
        Connexion()
      ],
    );
  }
}
