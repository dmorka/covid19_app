import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:covid19_app/models/volunteer.dart';


final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
final CollectionReference annoucementCollection =
    FirebaseFirestore.instance.collection('annoucements');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService._internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService._internal();

  Future<UserModel> createUser(UserModel user) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.doc(user.id));

      final Map<String, dynamic> data = user.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return FirebaseFirestore.instance
        .runTransaction(createTransaction)
        .then((mapData) {
      return UserModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<Annoucement> createAnnoucement(Annoucement annoucement) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(annoucementCollection.doc());

      annoucement.id = ds.id;
      final Map<String, dynamic> data = annoucement.toMap();

      await tx.set(ds.reference, data, SetOptions(merge: true));

      return data;
    };

    return FirebaseFirestore.instance
        .runTransaction(createTransaction)
        .then((mapData) {
      return Annoucement.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<dynamic> getAllAnnoucements() async {
    List<Annoucement> annoucements = new List<Annoucement>();

    await annoucementCollection.get().then((value) {
      if (value.size > 0) {
        value.docs
            .forEach((element) => annoucements.add(Annoucement.map(element)));
      } else {
        print("Empty query!");
      }
    });

    return annoucements;
  }

  Future<List<VolunteerModel>> getVolunteers(
      List volunteerIDs) async {
    if (volunteerIDs.length == 0)
      return null;
    List<VolunteerModel> volunteers = new List<VolunteerModel>();
    print(volunteerIDs);
    await userCollection
        .where('id', whereIn: volunteerIDs)
        .get()
        .then((value) {
      if (value.size > 0) {
        value.docs
            .forEach((element) => volunteers.add(VolunteerModel.map(element)));
      } else {
        print("Empty query!");
      }
    });

    return volunteers;
  }

  Future<List<Annoucement>> getAnnoucements(
      String field, String equalTo) async {
    List<Annoucement> annoucements = new List<Annoucement>();

    await annoucementCollection
        .where(field, isEqualTo: equalTo)
        .get()
        .then((value) {
      if (value.size > 0) {
        value.docs
            .forEach((element) => annoucements.add(Annoucement.map(element)));
      } else {
        print("Empty query!");
      }
    });

    return annoucements;
  }

  Future<List<Annoucement>> getAnnoucementsWithVolunteers(
      List<String> volunteerIds) async {
    List<Annoucement> annoucements = new List<Annoucement>();

    await annoucementCollection
        .where('volunteers', arrayContainsAny: volunteerIds)
        .get()
        .then((value) {
      if (value.size > 0) {
        value.docs
            .forEach((element) => annoucements.add(Annoucement.map(element)));
      } else {
        print("Empty query!");
      }
    });

    return annoucements;
  }

  Future<UserModel> getUser(String userId) async {
    final DocumentSnapshot ds = await userCollection.doc(userId).get();
    return UserModel.map(ds);
  }

  Future<dynamic> updateUser(UserModel user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.doc(user.id));
      await tx.set(ds.reference, user.toMap(), SetOptions(merge: true));
      return {'updated': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> updateAnnoucement(Annoucement annoucement) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(annoucementCollection.doc(annoucement.id));

      await tx.update(ds.reference, annoucement.toMap());
      return {'updated': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteUser(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.doc(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteAnnoucement(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(annoucementCollection.doc(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> addVolunteer(String annoucementId, String userId) {
    final TransactionHandler addVolunteerTransaction =
        (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(annoucementCollection.doc(annoucementId));

      await tx.update(ds.reference, {
        "volunteers": FieldValue.arrayUnion([userId])
      });
      return {'updated': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(addVolunteerTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> addDeviceToken(String userId, String token) {
    final TransactionHandler addDeviceTokenTransaction =
        (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.doc(userId));

      await tx.set(
          ds.reference,
          {
            "deviceTokens": FieldValue.arrayUnion([token])
          },
          SetOptions(merge: true));
      return {'updated': true};
    };

    return FirebaseFirestore.instance
        .runTransaction(addDeviceTokenTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
