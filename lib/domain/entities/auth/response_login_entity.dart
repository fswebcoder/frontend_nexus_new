import 'package:equatable/equatable.dart';
import 'package:frontend_nexus/domain/entities/auth/response_companies_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_document_type_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_tokens_entity.dart';

class ResponseLoginEntity extends Equatable {
  final String id;
  final String documentNumber;
  final String email;
  final bool requirePasswordReset;
  final List<ResponseCompaniesEntity> companies;
  final ResponseDocumentTypeEntity documentTypes;
  final ResponseTokensEntity tokens;


  const ResponseLoginEntity({
    required this.id,
    required this.documentNumber,
    required this.email,
    required this.requirePasswordReset,
    required this.companies,
    required this.documentTypes,
    required this.tokens,
  });

  @override
  List<Object?> get props => [id, documentNumber, email, requirePasswordReset, companies, documentTypes, tokens];
}