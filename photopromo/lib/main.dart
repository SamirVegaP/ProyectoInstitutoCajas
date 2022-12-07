// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photopromo/models/user.dart';
import 'package:photopromo/pages/add_user_page.dart';
import 'package:photopromo/pages/profile_page.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cajas DPW 2022",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => LandingApp(),
        '/profilepage': (context) => ProfilePage(),
        '/adduser': (context) => AddUserPage(),
      },
      home: const LandingApp(),
    );
  }
}

Widget buildUser(User user) {
  Future setActualUser(User user) async {
    final docUser =
        FirebaseFirestore.instance.collection('actualuser').doc("my id");

    final json = user.toJson();

    await docUser.set(json);

    return true;
  }

  return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 220,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 4.0, color: Colors.red),
          right: BorderSide(width: 4.0, color: Colors.indigo),
        ),
        color: Color.fromRGBO(230, 230, 230, 0.9),
      ),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                user.useName,
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.network(
                    user.useImg,
                    height: 120,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "''${user.usePhrase}''",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.useCarrier,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Cumpleaños: ${user.useBirthday}",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Edad: ${user.useAge}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Email: \n ${user.useEmail} \n \n Teléfono: \n ${user.usePhone}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    setActualUser(user);
                    navigatorKey.currentState?.pushNamed("/profilepage");
                  },
                  child: Text("Saber más"))
            ],
          )
        ],
      ));
}

Stream<List<User>> readUserList() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

class LandingApp extends StatefulWidget {
  const LandingApp({super.key});

  @override
  State<LandingApp> createState() => _LandingAppState();
}

class _LandingAppState extends State<LandingApp> {
  Widget build(BuildContext context) {
    BuildContext contextTwo = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Promoción 2022 - IESTP Cajas"),
      ),
      body: StreamBuilder(
        stream: readUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
                "Algo anda mal /n Código de consulta: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(12),
              children: users.map(buildUser).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_reaction),
        onPressed: () {
          navigatorKey.currentState?.pushNamed("/adduser");
        },
      ),
    );
  }
}
