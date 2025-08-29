import 'package:frontend_nexus/core/style/app_layout.dart';

enum FontSizeEnum{
  h1(AppLayout.fontH1),
  h2(AppLayout.fontH2),
  h3(AppLayout.fontH3),
  h4(AppLayout.fontH4),
  h5(AppLayout.fontH5),
  bigTitle(AppLayout.fontBigTitle);

  final double fontSize;

  const FontSizeEnum(this.fontSize);
}