import '../models/user.dart';
import '../services/user_services.dart';

class DatabaseRepository  {
  DatabaseService service = DatabaseService();

  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  Future<bool> retrieveUserData(String username) {
    return service.retrieveUser(username);
  }
}