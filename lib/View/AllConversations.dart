import 'package:flutter/material.dart';
import 'package:messagerie_ipssi/Model/Conversation.dart';
import 'package:messagerie_ipssi/View/detailConversation.dart';

import '../Fonctions/FirestoreHelper.dart';

class AllConversations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllConversationsState();
  }
}

class AllConversationsState extends State<AllConversations> {
  late Stream<List<Conversation>> conversationsStream;

  @override
  void initState() {
    conversationsStream = FirestoreHelper()
        .fireConversation
        .snapshots()
        .asyncMap((conversations) => Future.wait([
              for (var conversation in conversations.docs)
                FirestoreHelper().generateConversation(conversation)
            ]));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AllConversations oldWidget) {
    conversationsStream = FirestoreHelper()
        .fireConversation
        .snapshots()
        .asyncMap((conversations) => Future.wait([
              for (var conversation in conversations.docs)
                FirestoreHelper().generateConversation(conversation)
            ]));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }

  Widget bodyPage() {
    return StreamBuilder<List<Conversation>>(
        stream: conversationsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List documents = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(35),
            child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  String title = documents[index].firstUser.uid ==
                          FirestoreHelper().getCurrentUserId()
                      ? documents[index].secondUser.prenom
                      : documents[index].firstUser.prenom;
                  return Card(
                    elevation: 5.0,
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return detailConversation(
                              conversation: documents[index]);
                        }));
                      },
                      //Image
                      // leading: ImageRond(image: users.image,size:60),
                      title: Text(title),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      // subtitle: Text("${users.mail}"),
                    ),
                  );
                }),
          );
        });
  }
}
