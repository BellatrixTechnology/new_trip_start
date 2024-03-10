import 'package:flutter/cupertino.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/services/index.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        srvPageRoute.goBack(context);
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: boxShadow()),
        child: const Icon(
          CupertinoIcons.chevron_back,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
