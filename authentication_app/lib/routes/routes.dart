import 'package:authentication_app/modules/home/screns/home_screen.dart';
import 'package:authentication_app/modules/login/screens/login_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String initialRoute = '/login';

  static final List<GetPage> listRoutes = [

    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/home', page: () => const HomeScreen())

  ];
}
