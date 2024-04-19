// import 'package:new_trip_start/services/Routing.service.dart';
import 'package:new_trip_start/services/analytics.service.dart';
import 'package:new_trip_start/services/api.service.dart';
import 'package:new_trip_start/services/firebase.service.dart';
import 'package:new_trip_start/services/loader.service.dart';
import 'package:new_trip_start/services/osgridconverter.service.dart';
import 'package:new_trip_start/services/page_route.dart';
import 'package:new_trip_start/services/payment.service.dart';
import 'package:new_trip_start/services/rating.service.dart';
import 'package:new_trip_start/services/revenue_cat_sub.service.dart';
import 'package:new_trip_start/services/shared.service.dart';
import 'package:new_trip_start/services/toast_alert.service.dart';
import 'package:new_trip_start/services/user.service.dart';

PageRoute srvPageRoute = PageRoute();
FirebaseService srvFirebase = FirebaseService();
ToastAlertService srvToastAlert = ToastAlertService();
ApiService srvApi = ApiService();
// RoutingService srvRouting = RoutingService();
OsGridConverter srvOsGridConverter = OsGridConverter();
UserService srvUser = UserService();
SharedService srvShared = SharedService();
LoaderService srvLoader = LoaderService();
PaymentService srvPaymentService = PaymentService();
RevenueCatSubscriptionService srvRevenueCatSub =
    RevenueCatSubscriptionService();

AnalyticsService srvAnalytics = AnalyticsService();
RatingService srvRating = RatingService();
