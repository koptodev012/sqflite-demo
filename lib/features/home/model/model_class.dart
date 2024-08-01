// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelClass {
  int? id;
  String name;
  int age;
  ModelClass({
    this.id,
    required this.name,
    required this.age,
  });

  ModelClass copyWith({
    int? id,
    String? name,
    int? age,
  }) {
    return ModelClass(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory ModelClass.fromMap(Map<String, dynamic> map) {
    return ModelClass(
      id: map['id'] as int,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelClass.fromJson(String source) =>
      ModelClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ModelClass(id: $id, name: $name, age: $age)';

  @override
  bool operator ==(covariant ModelClass other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.age == age;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode;
}
