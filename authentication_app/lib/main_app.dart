import 'package:authentication_app/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  
  // Constructor for MainApp
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Hides the debug banner from the app
      debugShowCheckedModeBanner: false,

      // Sets the application title
      title: 'Authentication APP',

      // Defines the initial route of the application
      initialRoute: Routes.initialRoute,

      // Registers the list of routes available in the application
      getPages: Routes.listRoutes,
    );
  }
}
