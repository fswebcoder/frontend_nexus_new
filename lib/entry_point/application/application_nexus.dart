import 'package:flutter/material.dart';

import '../../core/utils/index.dart';

class ApplicationNexus extends StatefulWidget {
  const ApplicationNexus({super.key});

  @override
  State<ApplicationNexus> createState() => _ApplicationNexusState();
}

class _ApplicationNexusState extends State<ApplicationNexus>
    with WidgetsBindingObserver {
  bool modoOscuro = SingletonSharedPreferencesImp().darkMode ?? false;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
