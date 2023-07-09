import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';
import 'package:rentbike/model/sepeda_model.dart';
import 'package:rentbike/view/sepeda/add_sepeda.dart';
import 'package:rentbike/view/sepeda/update_sepeda.dart';

class BikeHome extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('sepedas');

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
          subtitle: Text(
            'Zahran Rafif',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          //check apakah ada error
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ada masalah'),
            );
          }

          //jika data berhasil diterima
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            //konversi data ke list
            List<Sepeda> sepedas = documents
                .map((e) => Sepeda(
                    id: e['id'],
                    name: e['name'],
                    nomor: e['nomor'],
                    imageUrl: e['imageUrl']))
                .toList();

            return _getBody(sepedas);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSepeda()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getBody(sepedas) {
    return sepedas.isEmpty
        ? const Center(
            child: Text(
              'Tidak ada data sepeda + mulai menambahkan',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: sepedas.length,
            itemBuilder: (context, index) => Card(
              elevation: 2, //menambah elevasi pada card
              margin: EdgeInsets.symmetric(
                  horizontal: 0, vertical: 10), //menambahkan margin card
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8)), //mengubah border menjadi rounded
              child: ListTile(
                //tampil nama sepeda
                title: Text(
                  sepedas[index].name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),

                //tampil nomor sepeda
                subtitle: Text(
                  'Nomor : ${sepedas[index].nomor}',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                //lingkarang foto
                leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.amber.shade200,
                    foregroundColor: Colors.black,
                    backgroundImage: NetworkImage(sepedas[index].imageUrl)),
                trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.edit_outlined),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateSepeda(sepeda: sepedas[index])));
                          },
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () {
                            _reference.doc(sepedas[index].id).delete();
                            //to refresh
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BikeHome()));
                          },
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
