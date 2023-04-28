import 'package:flutter/widgets.dart';
import 'package:pet_management/models/user.dart';
import 'package:pet_management/services/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User _user =
      User(bio: 'bio', email: 'email', uid: 'id', username: 'username');
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
