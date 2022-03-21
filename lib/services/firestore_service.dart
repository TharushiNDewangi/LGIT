import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// ignore: slash_for_doc_comments
/**From Tutorial
 * this followuser function i get 2 parameters.
 * these are current user id and follow user id.
 * go to collection and document uid(doc(uid)) then get the data as usuallaly
 * get these data and store it in DocumentSnapshot.
 * After that get following list and store it in List type variable(followingUsers) 
 */
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List followingUsers = (snap.data()! as dynamic)['following'];
/**From Tutorial
 * check that user(loged user(uid own user)) already follow that person(followId own person)
 * if it already follow remove that fellowid from the list
 *  
 * 1st method i removed uid from followId own followers list
 * Then removed followId from uid own following list
 * 
 * Else (if logged user not follow yet that fellowid own person)
 * it want to follow them
 * 1st method i add uid to followuser(followid own person) followers list
 * then i add followid to logged user(uid own person) following list
 */
      if (followingUsers.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
