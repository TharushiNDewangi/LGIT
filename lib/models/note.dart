// /**
//  * created by IT19129518 Rathnayake R.M.D.M
//  */

class Note {
  late String id;
  late String title;
  late String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

/* Learn from a tutorial - This method will use to convert to JSON object*/
  Map<String, dynamic> toConvertJson() =>
      {"id": id, "title": title, "content": content};

  Note.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        title = snapshot.data()['title'],
        content = snapshot.data()['content'];
}
