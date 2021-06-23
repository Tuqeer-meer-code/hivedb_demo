import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/models/contact.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hive database",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox('contacts'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
            else
              return contactPage();
            }else
              return Scaffold();
          },
        ));
  }
}
