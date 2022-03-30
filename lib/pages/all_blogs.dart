import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_blog.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class AllBlogs extends StatefulWidget {
  const AllBlogs({Key? key}) : super(key: key);

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  final Stream<QuerySnapshot> _firebase =
      FirebaseFirestore.instance.collection('blogs').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const <Widget>[
        //       Text(
        //         "Learn Git",
        //         style: TextStyle(fontSize: 22, color: Colors.blue),
        //       ),
        //     ],
        //   ),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.5,
        // ),
        body: StreamBuilder(
            stream: _firebase,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: (() {}),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                elevation: 0.4,
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.docChanges[index]
                                          .doc['blogPicUrl'],
                                      width: 390,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                snapshot.data!.docChanges[index]
                                                    .doc['title'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              snapshot.data!.docChanges[index]
                                                  .doc['authorName'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              snapshot.data!.docChanges[index]
                                                  .doc['description'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 270, 0)),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) => EditBlog(
                                                              documentid:
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index]),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ))
                          ],
                        ));
                  },
                ),
              );
            }));
  }
}
