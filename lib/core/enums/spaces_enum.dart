import 'package:frontend_nexus/core/style/app_layout.dart';

enum SpacesEnum {
  s(AppLayout.spaceS),
  m(AppLayout.spaceM),
  l(AppLayout.spaceL),
  xl(AppLayout.spaceXL),
  xxl(AppLayout.spaceXXL),
  xxxl(AppLayout.spaceXXXL);

  final double space;

  const SpacesEnum(this.space);
}