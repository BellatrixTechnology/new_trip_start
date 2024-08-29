import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UnlimitedTextView extends StatelessWidget {
  const UnlimitedTextView({super.key});

  @override
  Widget build(BuildContext context) {
    Package monthly = srvRevenueCatSub.getMonthly();
    // print(monthly);
    TextStyle? textStyle = const TextStyle(color: k51Color, fontSize: 16);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Unlimited free access for 7 days, then'.tr,
        style: GoogleFonts.poppins(textStyle: textStyle),
        children: <TextSpan>[
          // TextSpan(
          //     text: 'per year'
          //         .trParams({"price": yearly.storeProduct.priceString}),
          //     style: GoogleFonts.poppins(
          //         textStyle: const TextStyle(
          //             color: kPrimaryColorLight, fontSize: 16))),
          TextSpan(
              text: 'month'.trParams({
                "price":
                    "${monthly.storeProduct.currencyCode} ${(monthly.storeProduct.price).toStringAsFixed(2)}",
              }),
              style: GoogleFonts.poppins(textStyle: textStyle)),
        ],
      ),
    );
  }
}
