import 'dart:convert';

class CreditCardModel {
  final String number;
  final String name;
  final String expiration;
  final String cvv;
  final String hash;
  final String id;
  CreditCardModel({
    this.number = "",
    this.name = "",
    this.expiration = "",
    this.cvv = "",
    this.hash = "",
    this.id = "",
  });

  CreditCardModel copyWith({
    String? number,
    String? name,
    String? expiration,
    String? cvv,
    String? hash,
    String? id,
  }) {
    return CreditCardModel(
      number: number ?? this.number,
      name: name ?? this.name,
      expiration: expiration ?? this.expiration,
      cvv: cvv ?? this.cvv,
      hash: hash ?? this.hash,
      id: id ?? this.id,
    );
  }

  String queryString() =>
      "card_number=$number&card_holder_name=$name&card_expiration_date=$expiration&card_cvv=$cvv";

  Map<String, dynamic> toMap() {
    return {
      'card_number': number,
      'card_name': name,
      'card_expiration_date': expiration,
      'card_cvv': cvv,
      'card_hash': hash,
      'card_id': id,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      number: map['card_number'],
      name: map['card_name'],
      expiration: map['card_expiration_date'],
      cvv: map['card_cvv'],
      hash: map['card_hash'],
      id: map['card_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCardModel.fromJson(String source) =>
      CreditCardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditCardModel(number: $number, name: $name, expiration: $expiration, cvv: $cvv, hash: $hash, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreditCardModel &&
        other.number == number &&
        other.name == name &&
        other.expiration == expiration &&
        other.cvv == cvv &&
        other.hash == hash &&
        other.id == id;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        name.hashCode ^
        expiration.hashCode ^
        cvv.hashCode ^
        hash.hashCode ^
        id.hashCode;
  }
}
