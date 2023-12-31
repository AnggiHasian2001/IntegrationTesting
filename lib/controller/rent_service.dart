import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentbike/model/rent_model.dart';

class RentService {
  final rentCollection = FirebaseFirestore.instance.collection('rentbikeApp');

  //CREATE
  void addNewRent(RentModel model) {
    rentCollection.add(model.toMap());
  }

  //UPDATE
  void updateRent(String? docID, bool? valueUpdate) {
    rentCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  //DELETE
  void deleteRent(String? docID) {
    rentCollection.doc(docID).delete();
  }
}
