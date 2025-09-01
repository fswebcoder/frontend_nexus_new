import 'package:equatable/equatable.dart';

class ParametrosLoginEntity extends Equatable {
  final String username;
  final String password;

  const ParametrosLoginEntity({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
