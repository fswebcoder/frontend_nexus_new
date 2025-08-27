import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/blocs/provider/index.dart'
    show Provider, Bloc;
import '../base_mixins/focus_change_mixin.dart' show FocusChangeMixin;
import '../base_mixins/redirect_to_login_mixin.dart' show RedirectToLoginMixin;

abstract class BaseStateBloc<T extends StatefulWidget, Z extends Bloc>
    extends State<T>
    with FocusChangeMixin, RedirectToLoginMixin {
  late Z? bloc;

  BaseStateBloc();

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<Z>(getBlocInstance);
  }

  @override
  void dispose() {
    Provider.dispose<Z>();
    super.dispose();
  }

  Z getBlocInstance();
}
