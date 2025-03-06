import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfEntryExists(
    String collectionName, String fieldName, dynamic value) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .where(fieldName, isEqualTo: value)
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<int?> documentCount(String collectionName) async {
  AggregateQuerySnapshot query =
      await FirebaseFirestore.instance.collection(collectionName).count().get();
  return query.count;
}

Future<Map<String, dynamic>?> getEntryByIndex(
    String collectionName, int index) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .orderBy(FieldPath
          .documentId) // Change this field if you need a specific order
      .limit(index + 1) // Fetch documents up to the desired index
      .get();

  if (querySnapshot.docs.length > index) {
    return querySnapshot.docs[index].data()
        as Map<String, dynamic>; // Convert to JSON
  } else {
    return null; // Index out of range
  }
}

Future<void> deleteEntryWhere(
    String collectionName, String fieldName, dynamic value) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .where(fieldName, isEqualTo: value)
      .get();

  for (DocumentSnapshot doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
}

Future<void> updateEntryWhere(
  String collectionName, String fieldName, dynamic value, Map<String, dynamic> data) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .where(fieldName, isEqualTo: value)
      .get();

  for (DocumentSnapshot doc in querySnapshot.docs) {
    await doc.reference.update(data);
  }
}
