import 'dart:ui';
import 'package:equatable/equatable.dart';

class ResponseBrandingEntity extends Equatable {
  final String logo;
  final String primaryColor;
  final String secondaryColor;
  final String tertiaryColor;

  const ResponseBrandingEntity({
    required this.logo,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });

  factory ResponseBrandingEntity.fromJson(Map<String, dynamic> json) {
    return ResponseBrandingEntity(
      logo: json['logo'] ?? '',
      primaryColor: json['primaryColor'] ?? '#000000',
      secondaryColor: json['secondaryColor'] ?? '#000000',
      tertiaryColor: json['tertiaryColor'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'tertiaryColor': tertiaryColor,
    };
  }

  Color get primaryColorValue => _colorFromHex(primaryColor);
  Color get secondaryColorValue => _colorFromHex(secondaryColor);
  Color get tertiaryColorValue => _colorFromHex(tertiaryColor);

  Color _colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  List<Object?> get props => [logo, primaryColor, secondaryColor, tertiaryColor];
}
