import 'package:frontend_nexus/domain/entities/auth/parametros_login_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_login_entity.dart';
import 'package:frontend_nexus/entry_point/shared/models/general_response.dart';

abstract class LoginRepository {
    Future<GeneralResponse<ResponseLoginEntity>> login(ParametrosLoginEntity parametrosLogin);
}