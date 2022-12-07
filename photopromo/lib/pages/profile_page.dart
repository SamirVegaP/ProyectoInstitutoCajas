import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photopromo/main.dart';
import 'package:photopromo/models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Stream<List<User>> readUserActualList() => FirebaseFirestore.instance
    .collection('actualuser')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tu Perfil Cajasino"),
      ),
      body: StreamBuilder(
        stream: readUserActualList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
                "Algo anda mal /n Código de consulta: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(12),
              children: users.map(generateUserApp).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget generateUserApp(User user) {
  return Container(
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(300)),
          child: Image.network(user.useImg),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.useName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.blueAccent,
              ),
              child: Text(
                "${user.useAge}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "''${user.usePhrase}''",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(230, 230, 230, 0.9),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  "https://img.icons8.com/fluency/512/birthday.png",
                  height: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Cumpleaños: \n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user.useBirthday,
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(230, 230, 230, 0.9),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  "https://img.icons8.com/fluency/512/phone.png",
                  height: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Teléfono: \n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user.usePhone,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11),
                )
              ],
            ),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(230, 230, 230, 0.9),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  "https://img.icons8.com/fluency/512/email.png",
                  height: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: \n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user.useEmail,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 9),
                )
              ],
            ),
          ),
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(230, 230, 230, 0.9),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  "https://img.icons8.com/fluency/512/supplier.png",
                  height: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Carrera: \n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user.useCarrier,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // ignore: prefer_const_constructors
            TextButton(
              onPressed: () {},
              child: Text(
                "Añadir como Amigo",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              // ignore: prefer_const_constructors
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteeUser(user.useId);
              },
              child: Text(
                "Eliminar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              // ignore: prefer_const_constructors
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.red),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future deleteeUser(String useid) async {
  final docuser = FirebaseFirestore.instance.collection("users").doc(useid);

  docuser.delete();
  return true;
}
