import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String? docID;
  final String nameRent;
  final String description;
  final String category;
  final String dateRent;
  final String timeRent;
  final bool isDone;
  RentModel({
    this.docID,
    required this.nameRent,
    required this.description,
    required this.category,
    required this.dateRent,
    required this.timeRent,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameRent': nameRent,
      'description': description,
      'category': category,
      'dateRent': dateRent,
      'timeRent': timeRent,
      'isDone': isDone,
    };
  }

  factory RentModel.fromMap(Map<String, dynamic> map) {
    return RentModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      nameRent: map['nameRent'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateRent: map['dateRent'] as String,
      timeRent: map['timeRent'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory RentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return RentModel(
      docID: doc.id,
      nameRent: doc['nameRent'],
      description: doc['description'],
      category: doc['category'],
      dateRent: doc['dateRent'],
      timeRent: doc['timeRent'],
      isDone: doc['isDone'],
    );
  }
}
