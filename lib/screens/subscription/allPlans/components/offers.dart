import 'package:flutter/cupertino.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';

class SubscriptionOffer extends StatelessWidget {
  const SubscriptionOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        item("Audio & text options"),
        const CustomSpacerWidthHeight(height: 16),
        item("Unlock 5,000+ nonfiction titles"),
        const CustomSpacerWidthHeight(height: 16),
        item("Blinks, Short casts, curated collections, and more"),
        const CustomSpacerWidthHeight(height: 16),
      ],
    );
  }

  Widget item(String text) {
    return Row(
      children: [
        Image.asset(subIconCheckIcon, width: 22),
        const CustomSpacerWidthHeight(width: 4),
        Flexible(
          child: AppText(
            text: text,
            color: k51Color,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
