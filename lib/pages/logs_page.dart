import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  static const routeName = "/logs";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Logs",
        ),
      ),
      body: FutureBuilder(
        // future: Future.delayed(
        //   const Duration(
        //     seconds: 2,
        //   ),
        //   (() => Future.value("boi")),
        // ),
        future: FirebaseFirestore.instance.collection('/logs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: Text('$index'),
                  title: Text(
                    snapshot.data!.docs.elementAt(index).data().toString(),
                  ),
                  subtitle: Text("place"),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
