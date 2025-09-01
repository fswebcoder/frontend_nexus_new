import 'package:frontend_nexus/domain/entities/auth/parametros_login_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_login_entity.dart';
import 'package:frontend_nexus/domain/repositories/auth/login_repository.dart';
import 'package:frontend_nexus/entry_point/shared/models/general_response.dart';
import 'package:injectable/injectable.dart';


@injectable
class LoginUsecase {
  final LoginRepository loginRepository;

  LoginUsecase({required this.loginRepository});

  Future<GeneralResponse<ResponseLoginEntity>> call(ParametrosLoginEntity parametrosLogin) async {
    return await loginRepository.login(parametrosLogin);
  }
} 