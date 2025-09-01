import 'package:frontend_nexus/domain/entities/auth/parametros_login_entity.dart';
import 'package:frontend_nexus/domain/entities/auth/response_login_entity.dart';
import 'package:frontend_nexus/entry_point/shared/models/general_response.dart';

mixin LoginApiSource {
  Future<GeneralResponse<ResponseLoginEntity>> login(ParametrosLoginEntity parametrosLogin);
}