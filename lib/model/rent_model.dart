import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String? docID;
  final String nameRent;
  final String description;
  final String category;
  final String dateRent;
  final String timeRent;
  RentModel({
    this.docID,
    required this.nameRent,
    required this.description,
    required this.category,
    required this.dateRent,
    required this.timeRent,
  });

  Map<String, dynamic> toMap() {
    return {
      'docID': docID,
      'nameRent': nameRent,
      'description': description,
      'category': category,
      'dateRent': dateRent,
      'timeRent': timeRent,
    };
  }

  factory RentModel.fromMap(Map<String, dynamic> map) {
    return RentModel(
      docID: map['docID'],
      nameRent: map['nameRent'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      dateRent: map['dateRent'] ?? '',
      timeRent: map['timeRent'] ?? '',
    );
  }

  factory RentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return RentModel(
        docID: doc.id,
        nameRent: doc['nameRent'],
        description: doc['description'],
        category: doc['category'],
        dateRent: doc['dateRent'],
        timeRent: doc['timeRent']);
  }
}
