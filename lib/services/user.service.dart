import 'package:new_trip_start/models/users.model.dart';

class UserService {
  NewUserModel user = NewUserModel(
      id: -1,
      email: "",
      token: "",
      dt: "",
      // udt: "",
      // count: 0,
      // limit: 0,
      // status: "",
      name: "",
      isSubscribe: false,
      verified: false);

  initUser(NewUserModel newUser) {
    user = newUser;
  }

  emptyUser() {
    return NewUserModel(
        id: -1,
        email: "",
        token: "",
        dt: "",
        isSubscribe: false,
        // udt: "",
        // count: 0,
        // limit: 0,
        // status: "",
        name: "",
        verified: false);
  }
}
