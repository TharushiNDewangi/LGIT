import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_git/constants/const.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  List answerList = [];

  Future<String> addAnswers(String answer) async {
    String res = "Success";
    String id = generateId();
    try {
      Map<String, dynamic> answers = {
        "id": id,
        "answer": answer,
      };

      await _firestore.collection("answers").doc(id).set(answers);
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future getAnswers() async {
    try {
      await _firestore.collection("answers").get().then((quertSnapshot) {
        for (var result in quertSnapshot.docs) {
          answerList.add(result.data());
          debugPrint("answerLIst - $answerList");
        }
      });

      return answerList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
