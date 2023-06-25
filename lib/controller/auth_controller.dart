import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user'); //ngebuat koleksi user

  bool get success => false;

  //login
  Future<UserModel?> signWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          uId: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
        );
        return currentUser;
      }
    } catch (e) {
      print('Error signing in: $e');
    }
    return null;
  }

  //register
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser =
            UserModel(uId: user.uid, email: user.email ?? '', name: name);

        //create a document in the users collection with the user's
        await userCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
