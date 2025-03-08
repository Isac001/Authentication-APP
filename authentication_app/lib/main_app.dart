import 'package:authentication_app/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication APP',
      initialRoute: Routes.initialRoute,
      getPages: Routes.listRoutes,
    );
  }
}
