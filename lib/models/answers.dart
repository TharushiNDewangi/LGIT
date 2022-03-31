class Answers {
  late String id;
  late String answer;

  Answers({
    required this.id,
    required this.answer,
  });

  Map<String, dynamic> toConvertJson() => {
        "id": id,
        "answer": answer,
      };

  Answers.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        answer = snapshot.data()['answer'];
}
