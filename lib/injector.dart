import 'package:frontend_nexus/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
@injectableInit
Future<void> configureInjection(String env) async {
  getIt.init(environment: env);
}
