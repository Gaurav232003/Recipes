import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'data.dart';

Future<int> fetchImages() async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ListResult result = await storage.ref('recipes1').listAll();

  for (final Reference ref in result.items) {
    final imageUrl = await ref.getDownloadURL();

    recipes1img.add(imageUrl);
  }
  print(recipes1img);

  final ListResult result3 = await storage.ref('images').listAll();
  for (final Reference ref in result3.items) {
    final im = await ref.getDownloadURL();
    images.add(im);
  }

  return 1;
}

Future<int> fetchdetails() async {
  count = await getCount();
  final ref = FirebaseDatabase.instance.ref();
  // final snapshot2 = await ref.child('count').get();
  // int c = 1;
  // if (snapshot2.exists) {
  //   c = snapshot2.value as int;
  //   count = c;
  //   print(c);
  // }

  for (int i = 1; i <= count; i++) {
    final snapshot = await ref.child('recipes1/$i').get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      recipes1.add(Recipes(
          type: values['type'],
          imgUrl: '',
          name: values['name'],
          id: values['id'],
          ingredients: List<String>.from(values['ingredients']),
          instructions: List<String>.from(values['instructions']),
          userRating: List<String>.from(values['userRating']),
          total: values['total'],
          n: values['n']));
    }
  }

  print('----------------');
  print('----------------------');
  print('ho gya');
  return 0;
}

Future<int> getCount() async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot2 = await ref.child('count').get();
  if (snapshot2.exists) {
    dynamic snapshotValue = snapshot2.value;
    int countValue = snapshotValue['count'];

// Print the value to verify
    return countValue;
  } else
    return -1;
}
