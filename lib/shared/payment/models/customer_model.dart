import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_pagarme_create/shared/payment/models/document_model.dart';

class CustomerModel {
  final String type;
  final String country;
  final String name;
  final List<DocumentModel> documents;
  final String externalId;
  final String email;
  final List<String> phoneNumbers;
  CustomerModel({
    required this.externalId,
    required this.type,
    required this.country,
    required this.name,
    required this.documents,
    required this.email,
    required this.phoneNumbers,
  });

  CustomerModel copyWith({
    String? type,
    String? country,
    String? name,
    List<DocumentModel>? documents,
    String? externalId,
    String? email,
    List<String>? phoneNumbers,
  }) {
    return CustomerModel(
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      email: email ?? this.email,
      externalId: externalId ?? this.externalId,
      type: type ?? this.type,
      country: country ?? this.country,
      name: name ?? this.name,
      documents: documents ?? this.documents,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone_numbers': phoneNumbers,
      'type': type,
      'country': country,
      'name': name,
      'external_id': externalId,
      'documents': documents.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      email: map['email'],
      phoneNumbers: map['phone_numbers'],
      type: map['type'],
      externalId: map['external_id'],
      country: map['country'],
      name: map['name'],
      documents: List<DocumentModel>.from(
          map['documents']?.map((x) => DocumentModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(type: $type, country: $country, name: $name, documents: $documents)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.type == type &&
        other.country == country &&
        other.name == name &&
        listEquals(other.documents, documents);
  }

  @override
  int get hashCode {
    return type.hashCode ^
        country.hashCode ^
        name.hashCode ^
        documents.hashCode;
  }
}
