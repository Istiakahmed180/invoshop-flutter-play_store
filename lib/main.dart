import 'package:ai_store/app.dart';
import 'package:ai_store/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    DependencyInjection.init();
    runApp(const MyApp());
  });
}
