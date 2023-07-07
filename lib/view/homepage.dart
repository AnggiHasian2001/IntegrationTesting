import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:rentbike/common/show_model.dart';
import 'package:rentbike/controller/auth_controller.dart';
import 'package:rentbike/provider/service_provider.dart';
import 'package:rentbike/view/login.dart';
import 'package:rentbike/view/sepeda/bikehome.dart';

import 'card_list_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  var cc = AuthController();
  final autCtr = AuthController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentData = ref.watch(fetchDataProvider);
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BikeHome()));
                },
                icon: const Icon(CupertinoIcons.car),
              ),
              IconButton(
                onPressed: () async {
                  await autCtr.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                icon: const Icon(CupertinoIcons.arrow_uturn_right),
              ),
            ]),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        //ukuran padding lebar
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          const Gap(20),
          Row(
            //biar jarak antara kiri dan kanan
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'PT Rental Sepeda UMY',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Gap(7),
                  Text(
                    'Selasa, 27 Juni 2023',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
              //Button tambah data
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD5E8FA),
                    foregroundColor: Colors.blue.shade800,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  context: context,
                  //menuju widget form tambah data
                  builder: (context) => AddNewRentModel(),
                ),
                child: const Text(
                  '+ Tambah Data',
                ),
              ),
            ],
          ),
          //List View Data
          const Gap(20),
          ListView.builder(
            //menghitung banyaknya data yg akan ditampilkan
            itemCount: rentData.value?.length ?? 0,
            shrinkWrap: true,
            //mengambil card dari widget CardListWidget
            itemBuilder: (context, index) => CardListWidget(getIndex: index),
          ),
        ]),
      )),
    );
  }
}
