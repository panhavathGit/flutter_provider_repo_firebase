import 'package:flutter/foundation.dart';

class somethingDTO{
  final String id;
  final String name;

  somethingDTO({required this.id, required this.name});
  
  //from firestore
  factory somethingDTO.fromFirestore(Map<String, dynamic> data, String documentId){
    return somethingDTO(id: documentId, name: data['name']);
  }

  //to firestore

}