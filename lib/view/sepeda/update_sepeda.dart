import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:rentbike/model/sepeda_model.dart';
import 'package:rentbike/view/sepeda/bikehome.dart';

class UpdateSepeda extends StatefulWidget {
  final Sepeda sepeda;
  UpdateSepeda({super.key, required this.sepeda});

  @override
  State<UpdateSepeda> createState() => _UpdateSepedaState();
}

class _UpdateSepedaState extends State<UpdateSepeda> {
  //variabel
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imgController = TextEditingController();

  //start untuk input gambar
  File? imageFile;

  Future getImage() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      setState(() {
        imageFile = File(PickedFile.path);
      });
    }
  }

  Future<String> uploadImageToFirebase() async {
    String imageUrl = '';
    if (imageFile != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
      }
    } else {
      print('No image selected.');
    }
    return imageUrl;
  }

  Future uploadImage() async {
    String url;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    await ref.putFile(imageFile!);
    url = await ref.getDownloadURL();
    return url;
  }

  Future<void> updateData() async {
    final imageUrl = await uploadImageToFirebase();
    if (imageUrl.isNotEmpty) {
      //update data sepeda
      Sepeda updatedSepeda = Sepeda(
          id: widget.sepeda.id,
          name: nameController.text,
          nomor: int.parse(nomorController.text),
          imageUrl: imageUrl);

      final CollectionReference =
          FirebaseFirestore.instance.collection('sepedas');
      CollectionReference.doc(updatedSepeda.id)
          .update(updatedSepeda.toJson())
          .whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BikeHome()));
      });
    }
  }

//buat nerima data
  @override
  void initState() {
    super.initState();
    nomorController.text = '${widget.sepeda.nomor}';
    nameController.text = widget.sepeda.name;
  }

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
          const SizedBox(height: 20),
          const Text(
            'Input Data Sepeda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              child: imageFile != null
                  ? Image.file(imageFile!)
                  : const Placeholder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Harap masukan gambar',
          ),
          getMyField(
              hinText: 'Nomor Sepeda',
              textInputType: TextInputType.number,
              controller: nomorController),
          getMyField(
              hinText: 'Nama Sepeda',
              textInputType: TextInputType.name,
              controller: nameController),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: updateData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue, // Warna latar belakang tombol
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 16), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengubah border tombol menjadi rounded
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 16, // Ukuran teks
                    fontWeight: FontWeight.bold, // Ketebalan teks
                    color: Colors.white, // Warna teks
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BikeHome()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber, // Warna latar belakang tombol
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 16), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengubah border tombol menjadi rounded
                  ),
                ),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    fontSize: 16, // Ukuran teks
                    fontWeight: FontWeight.bold, // Ketebalan teks
                    color: Colors.white, // Warna teks
                  ),
                ),
              ),
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))),
  );
}
