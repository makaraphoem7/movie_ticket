import 'models/user_account.dart';

class UserAccountData {
  static List<User> getUser() {
    return [
      User(
        id: 1,
        fistName: 'John',
        lastName: 'Doe',
        password: 'password',
        profilePath: '/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
        profile: 8.0,
      ),
      User(
        id: 2,
        fistName: 'John',
        lastName: 'Doe',
        password: 'password',
        profilePath: '/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
        profile: 8.0,
      ),
    ];
  }
}
