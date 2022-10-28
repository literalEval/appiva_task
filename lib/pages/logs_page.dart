import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        future: FirebaseFirestore.instance
            .collection('/logs')
            .orderBy("time", descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: ((context, index) {
                final currentDoc = snapshot.data!.docs.elementAt(index).data();

                // The image can also be retrieved using the timestamp

                return ListTile(
                  leading: Text('$index'),
                  title: Text(
                    'Lat: ${currentDoc['lat'].toString()}, '
                    'Lon: ${currentDoc['lon'].toString()}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    // Using 3rd party library for this simple task is overkill,
                    // but works fast and precisely, so why not

                    DateFormat.yMd().add_jm().format(
                          DateTime.fromMillisecondsSinceEpoch(
                            (currentDoc['time'] as Timestamp)
                                .millisecondsSinceEpoch,
                          ),
                        ),
                  ),
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
