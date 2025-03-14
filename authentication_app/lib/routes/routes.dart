import 'package:authentication_app/modules/home/screns/home_screen.dart';
import 'package:authentication_app/modules/login/screens/login_screen.dart';
import 'package:authentication_app/modules/user/screens/create_user_screen.dart';
import 'package:authentication_app/modules/user/screens/profile_user_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  
  // Defines the initial route when the app starts
  static const String initialRoute = '/login';

  // List of all defined routes in the application
  static final List<GetPage> listRoutes = [
    // Route for the login screen
    GetPage(name: '/login', page: () => const LoginScreen()),

    // Route for the home screen
    GetPage(name: '/home', page: () => const ProfileUserScreen()),

    // Route for the registration user screen
    GetPage(name: '/create_user', page: () => const CreateUserScreen())
  ];
}
