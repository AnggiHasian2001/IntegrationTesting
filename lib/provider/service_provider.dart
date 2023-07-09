import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentbike/model/rent_model.dart';
import 'package:rentbike/controller/rent_service.dart';

final serviceProvider = StateProvider<RentService>((ref) {
  return RentService();
});

//mengambil data dari firebase
final fetchDataProvider = StreamProvider<List<RentModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      //colection firebase
      .collection('rentbikeApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => RentModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
