import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devcamp_attendees/models/dev_camp_mentor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/dev_camp_user.dart';
import 'constants.dart';

class DatabaseService {
  Future<DevCampUser> getUser(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    return DevCampUser.fromDoc(userDoc);
  }

  Future<void> createUser(String displayName) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    DevCampUser user = DevCampUser(
      displayName: displayName,
      id: uid,
    );

    userCollection.add(user.toMap());
    return; // since it's a future void type
  }

  Future<List<DevCampUser>> searchUsers(
      String currentUserId, String name) async {
    QuerySnapshot usersSnap =
        await usersRef.where('name', isGreaterThanOrEqualTo: name).get();
    List<DevCampUser> users = [];
    for (var doc in usersSnap.docs) {
      DevCampUser user = DevCampUser.fromDoc(doc);
      if (user.id != currentUserId) {
        users.add(user);
      }
    }
    return users;
  }

  Future<List<DevCampUser>> getAllUsers() async {
    QuerySnapshot userSnapshot = await usersRef.get();
    List<DevCampUser> users = [];
    for (var doc in userSnapshot.docs) {
      DevCampUser user = DevCampUser.fromDoc(doc);
      users.add(user);
    }
    return users;
  }

  Future<List<String>> saveUsers(List<DevCampUser> users) async {
    List<String> ids = [];
    for (var user in users) {
      usersRef.add(user.toJson()).then((doc) => ids.add(doc.id));
    }
    return ids;
  }

  void updateUserAttendance(
      DevCampUser user, String session, bool value) async {
    usersRef.doc(user.id).update({
      session: value,
    });
  }

  void updateUser(
      String id,
      String name,
      String bio,
      String profileImageUrl,
      double rating,
      String? userStatus,
      Timestamp? acceptedOn,
      Timestamp? confirmedOn) async {
    usersRef.doc(id).update({
      "name": name,
      "bio": bio,
      "profileImageUrl": profileImageUrl,
      "rating": rating,
      "userStatus": userStatus,
      "acceptedOn": acceptedOn,
      "confirmedOn": confirmedOn,
    });
  }

  void updateUserJson(
    String id,
    Map<String, dynamic>? json,
  ) async {
    usersRef.doc(id).update(json!);
  }

  Future<void> deleteUser(String userId) async {
    var snapshot = usersRef.doc(userId);

    final batch = FirebaseFirestore.instance.batch();

    batch.delete(snapshot);

    return batch.commit();
  }

  Future<DevCampMentor> getMentor(String mentorId) async {
    DocumentSnapshot mentorDoc = await mentorsRef.doc(mentorId).get();
    return DevCampMentor.fromDoc(mentorDoc);
  }

  Future<List<DevCampMentor>> getAllMentors() async {
    QuerySnapshot mentorSnapshot = await mentorsRef.get();
    List<DevCampMentor> mentors = [];
    for (var doc in mentorSnapshot.docs) {
      DevCampMentor mentor = DevCampMentor.fromDoc(doc);
      mentors.add(mentor);
    }
    return mentors;
  }

  Future<List<String>> saveMentors(List<DevCampUser> mentors) async {
    List<String> ids = [];
    for (var mentor in mentors) {
      mentorsRef.add(mentor.toJson()).then((doc) => ids.add(doc.id));
    }
    return ids;
  }

  void updateMentorJson(
    String id,
    Map<String, dynamic>? json,
  ) async {
    mentorsRef.doc(id).update(json!);
  }

  // void insertbookmarkedEvent(String userId, String eventId) async {
  //   final documentReference =
  //       usersRef.doc(userId).collection("bookmarkedEvents").doc();

  //   final docId = documentReference.id;
  //   var bookMarkEvent = BookmarkedEvent(
  //       id: docId, eventId: eventId, createdDateTime: DateTime.now());
  //   await documentReference
  //       .set(bookMarkEvent.toDoc())
  //       .onError((error, stackTrace) => debugPrint(error.toString()));
  // }

  // Future<void> deletebookmarkedEvent(String userId, String eventId) async {
  //   var snapshot = await usersRef
  //       .doc(userId)
  //       .collection("bookmarkedEvents")
  //       .where('eventId', isEqualTo: eventId)
  //       .get();

  //   final batch = FirebaseFirestore.instance.batch();

  //   for (final doc in snapshot.docs) {
  //     batch.delete(doc.reference);
  //   }

  //   return batch.commit();
  // }
}
