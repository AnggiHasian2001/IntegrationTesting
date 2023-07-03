import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rentbike/model/sepeda_model.dart';
import 'package:rentbike/view/sepeda/add_sepeda.dart';

class BikeHome extends StatefulWidget {
  const BikeHome({super.key});

  @override
  State<BikeHome> createState() => _BikeHomeState();
}

class _BikeHomeState extends State<BikeHome> {
  List<Sepeda> sepedas = [
    Sepeda(id: 'id', name: 'Polygon', nomor: 12),
    Sepeda(id: 'id', name: 'Polygon', nomor: 12),
    Sepeda(id: 'id', name: 'Polygon', nomor: 12),
  ];

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
      body: sepedas.isEmpty
          ? const Center(
              child: Text('Tidak ada data sepeda + mulai menambahkan'),
            )
          : ListView.builder(
              itemCount: sepedas.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(sepedas[index].name),
                  subtitle: Text('Nomor : ${sepedas[index].nomor}'),
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text('${sepedas[index].nomor}'),
                  ),
                  trailing: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          InkWell(
                            child: const Icon(Icons.edit),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Icon(Icons.delete),
                            onTap: () {},
                          ),
                        ],
                      )),
                ),
              ),
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
}
