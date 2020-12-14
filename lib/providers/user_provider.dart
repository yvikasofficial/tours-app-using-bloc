import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tours_app/model/tour.dart';
import 'package:tours_app/providers/authentication_provider.dart';
import 'package:uuid/uuid.dart';

class UserProvider {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider();

  Future<void> uploadTourData(Tour tour) async {
    final String uid = _authenticationProvider.currentUser.uid;
    try {
      await _firebaseDb
          .collection("users/$uid/tours/")
          .doc(tour.uid)
          .set(Tour.toJson(tour));
    } catch (e) {
      throw e;
    }
  }

  Future<List<Tour>> getAllTours() async {
    final String uid = _authenticationProvider.currentUser.uid;
    try {
      final querySnap = await _firebaseDb.collection("users/$uid/tours/").get();
      if (querySnap.docs.length == 0) {
        return null;
      }
      return querySnap.docs.map((doc) => Tour.fromJson(doc.data())).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeTour(String docUid) async {
    final String uid = _authenticationProvider.currentUser.uid;
    try {
      _firebaseDb.collection("users/$uid/tours/").doc(docUid).delete();
    } catch (e) {
      throw e;
    }
  }
}
