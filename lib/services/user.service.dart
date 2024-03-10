import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_trip_start/models/users.model.dart';

class UserService {
  UserModel user = UserModel(
      isFreeTrial: false,
      email: "",
      isSubscribed: false,
      subsDueDate: "",
      subStartDate: "");

  initUser(User fbUser, Map fSUser) {
    user = UserModel(
        email: fbUser.email ?? fbUser.providerData[0].uid!,
        isSubscribed: fSUser['isSubscribed'],
        user: fbUser,
        isFreeTrial: fSUser['isFreeTrial'],
        subsDueDate: fSUser['subsDueDate'],
        subStartDate: fSUser['subStartDate']);
  }
}
