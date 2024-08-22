import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:new_trip_start/services/index.dart';

class AnalyticsService {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

  inituser() {
    // print(srvUser.user.user!.uid);
    firebaseAnalytics.setUserId(id: srvUser.user.id.toString());
  }

  addLog(String name, Map<String, Object?> param) {
    firebaseAnalytics.logEvent(name: name, parameters: param);
  }
}
