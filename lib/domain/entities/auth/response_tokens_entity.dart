
import 'package:equatable/equatable.dart';

class ResponseTokensEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const ResponseTokensEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ResponseTokensEntity.fromJson(Map<String, dynamic> json) {
    return ResponseTokensEntity(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  bool get isValid => accessToken.isNotEmpty && refreshToken.isNotEmpty;

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
