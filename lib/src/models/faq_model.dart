class FaqModel {
 late String question;
 late String answer;

  FaqModel({required this.question,required this.answer});

  factory FaqModel.fromDocument(json) {
    return FaqModel(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'question': question,
    'answer': answer,
  };
}