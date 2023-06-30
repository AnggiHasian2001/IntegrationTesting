import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentbike/model/rent_model.dart';

class RentService {
  final rentCollection = FirebaseFirestore.instance.collection('rentbikeApp');

  //CREATE
  void addNewRent(RentModel model) {
    rentCollection.add(model.toMap());
  }
}
