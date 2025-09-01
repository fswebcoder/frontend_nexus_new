import 'package:frontend_nexus/core/network/http_codes.dart';
import 'package:frontend_nexus/data/api_sources/auth/login_api_source.dart';
import 'package:frontend_nexus/data/utils/validate_status_enum.dart';
import 'package:frontend_nexus/domain/entities/auth/parametros_login_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_login_entity.dart';
import 'package:frontend_nexus/domain/repositories/auth/login_repository.dart';
import 'package:frontend_nexus/entry_point/application/config/global_message.dart';
import 'package:frontend_nexus/entry_point/shared/models/custom_error_result.dart';
import 'package:frontend_nexus/entry_point/shared/models/general_response.dart' show GeneralResponse;
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImp implements LoginRepository {
  final LoginApiSource loginApiSource;

  LoginRepositoryImp({required this.loginApiSource});

  @override
  Future<GeneralResponse<ResponseLoginEntity>> login(ParametrosLoginEntity parametrosLogin) async {
    final response = await loginApiSource.login(parametrosLogin);
    if (ValidateStatusEnum.validateStatus(response.statusCode.toString(), HttpCodes.ok.toString())) {
      return response;
    } else {
      throw CustomErrorResult(statusCode: response.statusCode ?? 0, message: response.message ?? GlobalMessage.generalError);
    }
  }
}