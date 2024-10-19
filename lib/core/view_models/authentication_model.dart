import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/network/app_storage.dart';
import 'package:vma/core/repositories/authentication_repository.dart';

class AuthenticationModel extends Model {
  bool _isAuthenticated = false;
  final AuthenticationRepository _repository = AuthenticationRepository();

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    final authResponse =
        await _repository.login(username: username, password: password);
    if (authResponse == null) {
      _isAuthenticated = false;
    } else {
      AppStorage().write("token", authResponse.accessToken);
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
