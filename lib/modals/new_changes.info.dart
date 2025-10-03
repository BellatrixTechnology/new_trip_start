import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class NewChangesInfoModal {
  showModal() {
    Get.bottomSheet(
      ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const CustomSpacer(spaceValue: 20),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {
                Get.close(0);
              },
              child: Ink(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kBgLightColor),
                    child: const AppText(
                      text: '\u2716',
                      // style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      // ),
                    )

                    //   IconButton(
                    //       onPressed: () {
                    //         Get.close(0);
                    //       },
                    //       icon: const Icon(
                    //         CupertinoIcons.clear,
                    //         size: 35,
                    //       )),
                    ),
              ),
            ),
          ),
          AppGradientBg(
              // color: kBgLightColor,
              // padding: const EdgeInsets.all(20),
              child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSpacer(spaceValue: 10),
              AppText(
                text: "new_features_info_page_title".tr,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const CustomSpacer(spaceValue: 8),
              AppText(text: "new_features_info_page_descp".tr),
              const CustomSpacer(spaceValue: 8),
              AppText(
                text: "features_we_added".tr,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const CustomSpacer(spaceValue: 8),
              item("feature_1".tr),
              const CustomSpacer(spaceValue: 5),
              item("feature_2".tr),
              const CustomSpacer(spaceValue: 5),
              item("feature_3".tr),
              const CustomSpacer(spaceValue: 5),
              item("feature_4".tr),
              const CustomSpacer(spaceValue: 10),
              AppText(
                text: "important_note".tr,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const CustomSpacer(spaceValue: 10),
              AppText(text: "important_note_desp".tr),
            ],
          )),
        ],
      ),
      isScrollControlled: true,
    );
  }

  item(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("●   "),
        Flexible(
            child: AppText(
          text: text,
        )),
      ],
    );
  }
}
