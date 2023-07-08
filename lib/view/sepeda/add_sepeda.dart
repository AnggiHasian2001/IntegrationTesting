import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentbike/model/sepeda_model.dart';
import 'package:rentbike/view/sepeda/bikehome.dart';

class AddSepeda extends StatefulWidget {
  @override
  State<AddSepeda> createState() => _AddSepedaState();
}

class _AddSepedaState extends State<AddSepeda> {
  final formKey = GlobalKey<FormState>();
  //variabel
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

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
    String imageUrl;
    if (imageFile != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        return imageUrl;
        // Gunakan URL gambar untuk keperluan selanjutnya, seperti menyimpan ke database
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
      }
    } else {
      print('No image selected.');
    }
    return '';
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
          //masuk ke galeri
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid)),
              child: imageFile != null ? Image.file(imageFile!) : Placeholder(),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Harap masukan gambar',
          ),
          const SizedBox(height: 20),
          getMyField(hinText: 'Nama Sepeda', controller: nameController),
          getMyField(
              hinText: 'Nomor Sepeda',
              textInputType: TextInputType.number,
              controller: nomorController),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final imageUrl = await uploadImageToFirebase();
                  if (imageUrl.isNotEmpty) {
                    // Lakukan sesuatu dengan URL gambar yang telah diunggah
                    print('URL Gambar: $imageUrl');

                    Sepeda sepeda = Sepeda(
                      name: nameController.text,
                      nomor: int.parse(nomorController.text),
                      imageUrl: imageUrl,
                    );

                    // Menambahkan data sepeda
                    addSepedaNavigateToHome(sepeda, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 16), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengubah border tombol menjadi rounded
                  ),
                ),
                child: Text(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BikeHome()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 16), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengubah border tombol menjadi rounded
                  ),
                ),
                child: Text(
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

  void addSepedaNavigateToHome(Sepeda sepeda, BuildContext context) {
    //mengacu ke firebase collection sepedas
    final sepedaRef = FirebaseFirestore.instance.collection('sepedas').doc();
    sepeda.id = sepedaRef.id;
    final data = sepeda.toJson();
    final imgurl = uploadImage();
    //menambahkan data sepeda, jika selesai langsung ke bikeHome
    sepedaRef.set(data).whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BikeHome(),
        ),
      );
    });
  }
}

//widget form tambah nomor sepeda, nama, gambar
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))),
  );
}
