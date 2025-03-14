import 'package:authentication_app/modules/user/models/user_model.dart';
import 'package:authentication_app/modules/user/services/user_service.dart';
import 'package:get/get.dart';

class ListUserController extends GetxController {
  final UserService _userService = UserService();

  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final fetchedUsers = await _userService.listUsers();
      users.assignAll(fetchedUsers);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel?> getUserDetail(int userId) async {
    try {
      return await _userService.detailUser(userId);
    } catch (error) {
      errorMessage.value = error.toString();

      return null;
    }
  }
}
