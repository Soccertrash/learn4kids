class LearningObject {
  final int id;
  final String explanationAudio;
  final String questionAudio;

  LearningObject({this.id, this.explanationAudio, this.questionAudio});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'explanationAudio': explanationAudio,
      'questionAudio': questionAudio,
    };
  }

  factory LearningObject.fromMap(Map<String, dynamic> map) => LearningObject(
      id: map['id'],
      explanationAudio: map['explanationAudio'],
      questionAudio: map['questionAudio']);
}
