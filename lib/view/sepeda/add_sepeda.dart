import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rentbike/view/sepeda/bikehome.dart';

class AddSepeda extends StatefulWidget {
  const AddSepeda({super.key});

  @override
  State<AddSepeda> createState() => _AddSepedaState();
}

class _AddSepedaState extends State<AddSepeda> {
  //variabel
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(onPressed: () {}, child: const Text('Simpan')),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BikeHome()));
                  },
                  child: const Text('Batal')),
            ],
          )
        ],
      )),
    );
  }
}

//form nomor sepeda, nama, gambar
Widget getMyField(
    {required String hinText,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: 'Masukkan Data $hinText',
            labelText: hinText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))))),
  );
}
