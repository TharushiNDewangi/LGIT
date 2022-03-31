import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:learn_git/screens/questionlist.dart';
import 'package:learn_git/services/comment_service.dart';

class AddAnswers extends StatefulWidget {
  const AddAnswers({Key? key}) : super(key: key);

  @override
  State<AddAnswers> createState() => _AddAnswerstate();
}

class _AddAnswerstate extends State<AddAnswers> {
  final answerController = TextEditingController();

  AnswerService answerService = new AnswerService();

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    primary: const Color(0xFF1C7EE7),
    fixedSize: const Size(350, 40),
    textStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    side: const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Learn Git",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.article_outlined,
                color: Colors.amber,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                        hintText: "Answer"),
                    controller: answerController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      answerService.addAnswers(
                        answerController.text,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionList()));
                    },
                    child: const Text('Upload Answer'),
                    style: btnstyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
