import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as beat_user;
import '../models/fire_user.dart' as fire_user;

class CollectionNames{
  static const users = 'users';
  static const sessions = 'sessions';
}

class UserService{
  Future<beat_user.User?> getUser(String userUid) async {
    try {
    final user = (await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(userUid)
    .get())
    .data();
    if (user == null) return null;
    return beat_user.User.fromMap(user);
    } catch (error) {
      print(error);
    }
  }

  Future<void> createUser(fire_user.User? userUid, String firstName, String lastName) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(userUid!.uid)
    .set({
          beat_user.UserKeys.uid: userUid.uid,
          beat_user.UserKeys.firstname: firstName,
          beat_user.UserKeys.lastname: lastName,
          beat_user.UserKeys.friends: []
        });
  }

  Future<void> updateUser(beat_user.User updatedUser) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(updatedUser.uid)
    .update(updatedUser.toMap());
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .delete();
  }

  Query<beat_user.User> getFriends(List<String> friendIds){
    return FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .where(FieldPath.documentId, whereIn: friendIds)
    .withConverter(
      fromFirestore: (snapshot, options) => beat_user.User.fromMap(snapshot.data()!), 
      toFirestore: (value, options) => value.toMap(),
    );
  }
}