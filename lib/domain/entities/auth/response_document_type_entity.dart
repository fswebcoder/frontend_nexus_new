import 'package:equatable/equatable.dart';

class ResponseDocumentTypeEntity extends Equatable {
  final String id;
  final String name;
  final String code;

  const ResponseDocumentTypeEntity({
    required this.id,
    required this.name,
    required this.code,
  });

  factory ResponseDocumentTypeEntity.fromJson(Map<String, dynamic> json) {
    return ResponseDocumentTypeEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [id, name, code];
}
