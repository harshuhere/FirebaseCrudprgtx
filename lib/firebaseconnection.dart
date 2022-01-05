import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConnection {
  final firestore = FirebaseFirestore.instance;

  Future<void> saveToFirebase(String name, String mobile, String email,
      String cityname, String index) async {
    await firestore.collection("data").add({
      "name": name,
      "mobile": mobile,
      "email": email,
      "cityname": cityname,
      "index": index,
    });
  }

  Future deleteData(String index) async {
    var collection = FirebaseFirestore.instance.collection("data");
    var snapshot = await collection.where('index', isEqualTo: index).get();
    await snapshot.docs.first.reference.delete();
  }

  Future updateData(String name, String mobile, String email, String cityname,
      String index) async {
    var collection = FirebaseFirestore.instance.collection("data");
    var snapshot = await collection.where('index', isEqualTo: index).get();
    await snapshot.docs.first.reference.update({
      "name": name,
      "mobile": mobile,
      "email": email,
      "cityname": cityname,
    });
  }

  Future getData() async {
    List datalist = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("data");
    try {
      await collectionReference.get().then((value) {
        value.docs.forEach((element) {
          datalist.add(element.data());
        });
      });
      return datalist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
