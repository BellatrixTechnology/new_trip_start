import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class FeedbackModal {
  TextEditingController ctrl = TextEditingController();
  double rating = 5;
  showModal(Function callback) {
    return Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: kBgLightColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: "Rate Your Experience".tr,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const CustomSpacer(spaceValue: 10),
              AppText(text: "Did the route meet your expectations?".tr),
              const CustomSpacer(spaceValue: 10),
              RatingBar.builder(
                initialRating: 5,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return const Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return const Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return const Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                  }
                  return const SizedBox();
                },
                onRatingUpdate: (rating) {
                  this.rating = rating;
                  // print(rating);
                },
              ),
              const CustomSpacer(spaceValue: 10),
              TextFormField(
                controller: ctrl,
                maxLength: 500,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Let us know here...".tr,
                  fillColor: kBoxColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                ),
              ),
              const CustomSpacer(spaceValue: 10),
              AppButton(
                  text: "Submit".tr,
                  press: () {
                    srvFirebase.addFeedBack(
                        feedback: ctrl.text, rating: rating);
                    Get.close(0);
                    callback();
                  },
                  showLoader: false),
              const CustomSpacer(spaceValue: 10),
              TextButton(
                  onPressed: () {
                    Get.close(0);
                    callback();
                  },
                  child: AppText(text: "Skip".tr))
            ],
          )),
      // barrierColor: Colors.red[50],
      // isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      enableDrag: false,
    );
    // showBottomSheet(context: context, builder: builder)
  }
}
