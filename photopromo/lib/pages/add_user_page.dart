// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photopromo/models/user.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.useId = docUser.id;

    final json = user.toJson();

    await docUser.set(json);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    final ageController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final phraseController = TextEditingController();
    final emailController = TextEditingController();
    final carrierController = TextEditingController();
    final imgController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Añade un Contacto"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu nombre',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu edad',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingrese su Fecha de Nacimiento',
            ),
            keyboardType: TextInputType.none,
            onTap: () async {
              DateTime? pickeddate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (pickeddate != null) {
                dateController.text = DateFormat('MMMd').format(pickeddate);
              }
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa número de celular',
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu email',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: carrierController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu carrera',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: phraseController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa una frase que te represente',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: imgController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu imagen (Por el momento, la URL)',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (nameController.text != "" &&
                    ageController.text != "" &&
                    dateController.text != "") {
                  if (num.parse(ageController.text) > 99 ||
                      num.parse(ageController.text) < 0 ||
                      IsDecimal(num.parse(ageController.text))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verificar ingreso de dato'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    final user = User(
                      useName: nameController.text,
                      useAge: int.parse(ageController.text),
                      useBirthday: dateController.text,
                      usePhone: phoneController.text,
                      useEmail: emailController.text,
                      useCarrier: carrierController.text,
                      usePhrase: phraseController.text,
                      useImg: imgController.text,
                    );
                    String nameuser = nameController.text;
                    createUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bienvenido ${nameuser}'),
                        backgroundColor: Colors.green,
                        action: SnackBarAction(
                          label: 'Otro Usuario',
                          textColor: Colors.white,
                          onPressed: () {
                            nameController.text = "";
                            ageController.text = "";
                            dateController.text = "";
                          },
                        ),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Verifica todos tus items ingresados'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Añade"))
        ],
      ),
    );
  }
}

bool IsDecimal(valuenumber) {
  if (valuenumber % 1 == 0) {
    return false;
  } else {
    return true;
  }
}
