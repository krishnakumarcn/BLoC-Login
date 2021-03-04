import 'models/models.dart';

class UserRepository {
  User _user;
  Future<User> getUser() async {
    if (_user != null) return _user;
    await Future.delayed(Duration(seconds: 1));
    _user = User("13400033");
    return _user;
  }
}
