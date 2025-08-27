mixin Bloc {
  void init();
  void dispose();

  void verifySinkAddStream(controller, Function function) {
    if (!controller.isClosed) function();
  }
}
