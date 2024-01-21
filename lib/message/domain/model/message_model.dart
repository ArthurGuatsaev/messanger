class MessageModel {
  final String message;
  final DateTime date;
  final bool mine;
  final String name;
  const MessageModel(
      {required this.message,
      required this.date,
      required this.mine,
      required this.name});

  MessageModel copyWith({
    String? message,
    DateTime? date,
    String? name,
    bool? mine,
  }) {
    return MessageModel(
      message: message ?? this.message,
      date: date ?? this.date,
      name: name ?? this.name,
      mine: mine ?? this.mine,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'date': date.millisecondsSinceEpoch,
      'mine': mine,
      'name': name
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      mine: map['mine'] as bool,
      name: map['name'] as String,
    );
  }
}
