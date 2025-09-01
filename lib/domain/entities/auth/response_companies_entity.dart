import 'package:equatable/equatable.dart';
import 'package:frontend_nexus/domain/entities/auth/response_branding_entity.dart';

class ResponseCompaniesEntity extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final ResponseBrandingEntity branding;

  const ResponseCompaniesEntity({
    required this.id,
    required this.name,
    required this.shortName,
    required this.branding,
  });

  factory ResponseCompaniesEntity.fromJson(Map<String, dynamic> json) {
    return ResponseCompaniesEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortName: json['shortName'] ?? '',
      branding: ResponseBrandingEntity.fromJson(json['branding'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'branding': branding.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, name, shortName, branding];
}
