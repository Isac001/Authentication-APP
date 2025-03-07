import 'package:authentication_app/controllers/initializer_controllers.dart';
import 'package:authentication_app/main_app.dart';
import 'package:flutter/widgets.dart';

void main() async {
  // Initializes application controllers
  InitializerControllers();

  // Runs the Flutter application inside a SafeArea
  runApp(
    const SafeArea(child: MainApp()),
  );
}
