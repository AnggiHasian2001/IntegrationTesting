// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:rentbike/model/sepeda_model.dart';
import 'package:rentbike/view/sepeda/bikehome.dart';

class UpdateSepeda extends StatelessWidget {
  //variabel
  final TextEditingController nomorController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final Sepeda sepeda;

  UpdateSepeda({super.key, required this.sepeda});

  @override
  Widget build(BuildContext context) {
    nomorController.text = '${sepeda.nomor}';
    nameController.text = sepeda.name;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset('assets/profile.png'),
          ),
          title: Text(
            'Admin',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          subtitle: const Text(
            'Zahran Rafif',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 20),
          getMyField(
              hinText: 'Nomor Sepeda',
              textInputType: TextInputType.number,
              controller: nomorController),
          getMyField(
              hinText: 'Nama Sepeda',
              textInputType: TextInputType.name,
              controller: nameController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    //update data sepeda
                    Sepeda updatedSepeda = Sepeda(
                        id: sepeda.id,
                        name: nameController.text,
                        nomor: int.parse(nomorController.text));

                    final CollectionReference =
                        FirebaseFirestore.instance.collection('sepedas');
                    CollectionReference.doc(updatedSepeda.id)
                        .update(updatedSepeda.toJson())
                        .whenComplete(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BikeHome()));
                    });
                  },
                  child: const Text('Update')),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BikeHome()));
                  },
                  child: const Text('Batal')),
            ],
          )
        ],
      )),
    );
  }
}

//form update nomor sepeda, nama, gambar
Widget getMyField(
    {required String hinText,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: 'Masukkan Data $hinText',
            labelText: hinText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))))),
  );
}
