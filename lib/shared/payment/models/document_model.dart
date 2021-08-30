import 'dart:convert';

class DocumentModel {
  final String type;
  final String number;
  DocumentModel({
    required this.type,
    required this.number,
  });

  DocumentModel copyWith({
    String? type,
    String? number,
  }) {
    return DocumentModel(
      type: type ?? this.type,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'number': number,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      type: map['type'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source));

  @override
  String toString() => 'DocumentModel(type: $type, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentModel &&
        other.type == type &&
        other.number == number;
  }

  @override
  int get hashCode => type.hashCode ^ number.hashCode;
}
