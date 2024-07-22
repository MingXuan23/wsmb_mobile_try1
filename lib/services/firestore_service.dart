import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wsmb_day1_try1/models/driver.dart';

class FirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<bool> isDuplicated(Driver driver) async {
    final queries = [
      firestore
          .collection('drivers')
          .where('icno', isEqualTo: driver.icno)
          .get(),
      firestore
          .collection('drivers')
          .where('phone', isEqualTo: driver.phone)
          .get(),
      firestore
          .collection('drivers')
          .where('email', isEqualTo: driver.email)
          .get(),
    ];

    // Perform all queries concurrently
    final querySnapshots = await Future.wait(queries);

    // Check if any of the queries returned documents
    final exists =
        querySnapshots.any((querySnapshot) => querySnapshot.docs.isNotEmpty);

    return exists;
  }

  static Future<Driver?> addDriver(Driver driver) async {
    try {
      var collection = await firestore.collection('drivers').get();

      driver.id = 'D${collection.size + 1}';
      var doc = firestore.collection('drivers').doc(driver.id);
      doc.set(driver.toJson());

      // var exist = await firestore
      //     .collection('drivers')
      //     .orwhere('icno', isEqualTo: driver.icno)
      //     .orwhere('phone', isEqualTo: driver.phone)
      //     .orwhere('email', isEqualTo: driver.email)
      //     .get();

      var driverDoc =
          await firestore.collection('drivers').doc(driver.id).get();

      Map<String, dynamic> data = driverDoc.data() as Map<String, dynamic>;
      Driver newDriver = Driver.fromJson(data);
      return newDriver;
    } catch (e) {
      return null;
    }
  }

  static Future<Driver?> loginDriver(String ic, String password) async {
    try {
      var collection = await firestore
          .collection('drivers')
          .where('icno', isEqualTo: ic)
          .where('password', isEqualTo: password)
          .get();

      if (collection.docs.isEmpty) {
        return null;
      }

      var doc = collection.docs.first;

      var driver = Driver.fromJson(doc.data());
      driver.id = doc.id;

      return driver;
    } catch (e) {
      return null;
    }
  }

  static Future<Driver?> validateTokenDriver(String token) async {
    try {
      var doc = await firestore.collection('drivers').doc(token).get();

      if (!doc.exists) {
        return null; // Document does not exist
      }

      // Check if document data is not null and convert to Driver object
      if (doc.data() != null) {
        return Driver.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null; // Document exists but data is null
      }
    } catch (e) {
      return null;
    }
  }
}
