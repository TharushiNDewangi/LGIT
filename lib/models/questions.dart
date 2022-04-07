/**
 * created by IT19159072 A.N.S.Thenuwara
 */
class Question {
  late String id;
  late String question;
  late String content;
  late String blogPicUrl;

  Question(
      {required this.id,
      required this.question,
      required this.content,
      required this.blogPicUrl});

  /**
   * From tutorial 
   * This method used to convert to a object file
   */
  Map<String, dynamic> toConvertJson() => {
        "id": id,
        "question": question,
        "content": content,
      };
/**
 * From Tutorial - convert snapshot to questions model
 */
  Question.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        question = snapshot.data()['question'],
        content = snapshot.data()['content'],
        blogPicUrl = snapshot.data()['blogPicUrl'];
}
