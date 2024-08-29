import 'package:get/get.dart';
import 'package:new_trip_start/utils/translations/en.dart';
import 'package:new_trip_start/utils/translations/nor.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'nn_NO': nnNO,
      };
}
