import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/constants/vma_roles.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/log_in_event.dart';
import 'package:vma/core/network/app_storage.dart';
import 'package:vma/core/repositories/authentication_repository.dart';
import 'package:vma/core/utils/token_helper.dart';

class AuthenticationModel extends Model {
  final AuthenticationRepository _repository = AuthenticationRepository();

  Future<void> login(String username, String password) async {
    final authResponse =
        await _repository.login(username: username, password: password);
    final loginEvent = LoginEvent();

    if (authResponse == null) {
      loginEvent.loginSuccess = false;
    } else {
      final String role = TokenHelper.getRole(authResponse.accessToken);
      if (role != VMARoles.veterinarian) {
        loginEvent.loginSuccess = false;
        return;
      }

      await AppStorage.write(AppStorageKeys.token, authResponse.accessToken);
      loginEvent.loginSuccess = true;
    }

    notifyListeners();
    EventManager.fire(loginEvent);
  }
}
