class Answers {
  late String id;
  late String answer;
  late String pid;
  /**
   * From tutorial 
   * This method used to convert to a object file
   */
  Answers({
    required this.id,
    required this.answer,
    required this.pid,
  });

  Map<String, dynamic> toConvertJson() =>
      {"id": id, "answer": answer, "pid": pid};
/**
 * From Tutorial - convert snapshot to questions model
 */
  Answers.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        answer = snapshot.data()['answer'],
        pid = snapshot.data()['pid'];
}
