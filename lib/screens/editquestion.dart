import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/addanswers.dart';
import 'package:learn_git/screens/questionlist.dart';

/**
 * created by IT19159072 A.N.S.Thenuwara
 * learn from tutorial - All question class will send the specific document id
 * If user wants to edit the deails user can  edit question and content
 * Edit question class will get that document id and extract the details 
 */
class EditQuestion extends StatefulWidget {
  late DocumentSnapshot documentid;

  EditQuestion({required this.documentid});

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  TextEditingController question = TextEditingController();
  TextEditingController content = TextEditingController();

  Uint8List? _image;
  late String imgUrl;

  @override
  void initState() {
    //the question and content will save in  the specific variable
    question = TextEditingController(text: widget.documentid.get('question'));
    content = TextEditingController(text: widget.documentid.get('content'));
    imgUrl = widget.documentid.get('blogPicUrl');
    super.initState();
  }

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
      ),
      body: Column(
        children: [
          Container(),
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Image.network(imgUrl,
                            fit: BoxFit.fitHeight, height: 180, width: 80)),
                    Padding(
                      child: Text("Question:"),
                      padding: EdgeInsets.fromLTRB(0, 2, 260, 2),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        controller: question,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                          hintText: 'question',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      child: Text("Content:"),
                      padding: EdgeInsets.fromLTRB(0, 2, 220, 2),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        maxLines: 8,
                        controller: content,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                          hintText: 'content',
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.documentid.reference.update({
                                'question': question.text,
                                'content': content.text,
                              }).whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QuestionList()));
                              });
                            },
                            icon: const Icon(Icons.update),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: () {
                              widget.documentid.reference
                                  .delete()
                                  .whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QuestionList()));
                              });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAnswers()));
              },
              backgroundColor: const Color(0xFF1C7EE7),
              child: const Icon(
                Icons.mode_edit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
